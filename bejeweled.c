#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <memory.h>
#include <time.h>
#include <stdint.h>

/*
#define L 8
#define C 7
#define LOGC 3
#define PLC 3232
#define H 8
*/

#define L 4
#define C 4
#define LOGC 2
#define PLC 12
#define H 4


#define SM (1<<L)

int bejpat[PLC][L],bejpatzip[PLC],bejpatc[PLC],wptr;

int stack[L],dstack[L],conv[L];
int dszip,same;
int pat2bej[1<<(LOGC*L)];

typedef uint64_t ans_t;
typedef ans_t layer_t[PLC][SM];

typedef uint16_t need_t;
need_t (*needtable)[PLC][SM][PLC];
#define need (*needtable)

layer_t layer[2];
layer_t *curlayer,*oldlayer,*xchglayer;
layer_t oldtrans;

ans_t mods[]={
    4294965793, 4294965821, 4294965839, 4294965841, 4294965847, 4294965887, 4294965911, 4294965937,
    4294965949, 4294965967, 4294965971, 4294965977, 4294966001, 4294966007, 4294966043, 4294966073,
    4294966087, 4294966099, 4294966121, 4294966129, 4294966153, 4294966163, 4294966177, 4294966187,
    4294966217, 4294966231, 4294966237, 4294966243, 4294966297, 4294966337, 4294966367, 4294966373,
    4294966427, 4294966441, 4294966447, 4294966477, 4294966553, 4294966583, 4294966591, 4294966619,
    4294966639, 4294966651, 4294966657, 4294966661, 4294966667, 4294966769, 4294966813, 4294966829,
    4294966877, 4294966909, 4294966927, 4294966943, 4294966981, 4294966997, 4294967029, 4294967087,
    4294967111, 4294967143, 4294967161, 4294967189, 4294967197, 4294967231, 4294967279, 4294967291
};

#define NMOD 6

int diffdg(int dep, int last, int lastrep){
    if(dep==L){
        if(pat2bej[dszip]<0){
            int coldef[C],colc=0,convzip=0;
            for(int i=0;i<C;i++){
                coldef[i]=-1;
            }
            for(int i=0;i<L;i++){
                if(coldef[dstack[i]]<0){
                    coldef[dstack[i]]=colc;
                    conv[i]=colc;
                    colc++;
                }else{
                    conv[i]=coldef[dstack[i]];
                }
                convzip=(convzip<<LOGC)|conv[i];
            }
            int bl=0,br=PLC,imid=0;
            while(bl<br){
                imid=(bl+br)>>1;
                if(bejpatzip[imid]<convzip){
                    bl=imid+1;
                }else if(bejpatzip[imid]>convzip){
                    br=imid;
                }else{
                    break;
                }
            }
            pat2bej[dszip]=imid;
        }
        need[wptr][same][pat2bej[dszip]]++;
        return 1;
    }
    int ans=0;
    for(int i=0;i<C;i++){
        if(i==stack[dep]){
            same=(same<<1)|1;
        }else{
            same=(same<<1);
        }
        dstack[dep]=i;
        dszip=(dszip<<LOGC)|i;
        if(i==last){
            if(lastrep<2)
                ans+=diffdg(dep+1,last,lastrep+1);
        }else{
            ans+=diffdg(dep+1,i,1);
        }
        same>>=1;
        dszip>>=LOGC;
    }
    return ans;
}

int dg(int dep,int last,int lastrep,int maxcol){
    if(dep==L){
        int stackzip=0;
        for(int i=0;i<L;i++){
            bejpat[wptr][i]=stack[i];
            stackzip=(stackzip<<LOGC)|stack[i];
        }
        bejpatc[wptr]=maxcol;
        bejpatzip[wptr]=stackzip;
        wptr++;
        return 1;
    }else{
        int ans=0;
        for(int i=0;i<maxcol;i++){
            stack[dep]=i;
            if(i==last){
                if(lastrep<2)
                    ans+=dg(dep+1,i,lastrep+1,maxcol);
            }else{
                ans+=dg(dep+1,i,1,maxcol);
            }
        }
        if(maxcol<C){
            stack[dep]=maxcol;
            ans+=dg(dep+1,maxcol,1,maxcol+1);
        }
        return ans;
    }
}
void datagen(){
    memset(pat2bej,-1,sizeof(pat2bej));
    
    for(int i=0;i<PLC;i++){
        wptr=i;
        for(int j=0;j<L;j++){
            putchar('0'+bejpat[i][j]);
            stack[j]=bejpat[i][j];
        }
        printf("[%d]",bejpatc[i]);
        same=0;
        printf(":%d\n",diffdg(0,0,0));
    }
    need_t max=0;
    for(int i=0;i<PLC;i++){
        for(int s=0;s<SM;s++){
            for(int j=0;j<PLC;j++){
                if(need[i][s][j]>max)
                    max=need[i][s][j];
                //printf("%d,",need[i][s][j]);
            }
            //putchar(' ');
        }
        //putchar('\n');
    }
    printf("max: %u\n",max);

}
ans_t samedg(int dep,int oldsame,int oldbej){
    if(dep==L){
        return (*oldlayer)[oldbej][same];
    }else{
        ans_t ans=0;
        same<<=1;
        ans+=samedg(dep+1,oldsame,oldbej);
        if(!(oldsame&(1<<(L-1-dep)))){
            same|=1;
            ans+=samedg(dep+1,oldsame,oldbej);
        }
        same>>=1;
        return ans;
    }
}
ans_t bejrun(ans_t mod){

    ans_t PCN[C+1]={1};
    for(int i=0;i<C;i++){
        PCN[i+1]=PCN[i]*(C-i);
    }
    curlayer=&layer[0];
    oldlayer=&layer[1];
    for(int i=0;i<PLC;i++){
        for(int s=0;s<SM;s++){
            (*curlayer)[i][s]=0;
        }
        (*curlayer)[i][0]=1;
    }
    for(int l=1;l<H;l++){
        xchglayer=oldlayer;
        oldlayer=curlayer;
        curlayer=xchglayer;
        printf("layer %d, transform ",l);
        
        for(int j=0;j<PLC;j++){
            for(int s=0;s<SM;s++){
                oldtrans[j][s]=samedg(0,s,j);
                if(mod)
                    oldtrans[j][s]%=mod;
            }
        }
        
        for(int i=0;i<PLC;i++){
            if((i&127)==0)
                printf("%d ",i);
            for(int s=0;s<SM;s++){
                
                (*curlayer)[i][s]=0;
                for(int j=0;j<PLC;j++){
                    (*curlayer)[i][s]+=oldtrans[j][s]*need[i][s][j];
                }
                if(mod)
                    (*curlayer)[i][s]%=mod;
            }
        }
        printf("\n");
    }
    /*
    for(int j=0;j<PLC;j++){
        for(int s=0;s<SM;s++){
            printf("%d ",(*curlayer)[j][s]);
        }
        putchar('\n');
    }
    */
    ans_t ans=0;
    for(int i=0;i<PLC;i++){
        for(int s=0;s<SM;s++){
            (*curlayer)[i][s]*=PCN[bejpatc[i]];
            ans+=(*curlayer)[i][s];
            if(mod)
                ans%=mod;
        }
    }
    printf("ans mod %u = %u\n",(uint32_t)mod,(uint32_t)ans);
    return ans;
}
void readneed(){
    FILE* fi=fopen("need.bin","rb");
    fread(need,sizeof(need),1,fi);
    fclose(fi);
    printf("readok\n");
}
void writeneed(){
    FILE* fo=fopen("need.bin","wb");
    fwrite(need,sizeof(need),1,fo);
    fclose(fo);
    printf("writeok\n");
}
void emutest(){
    int mat[H][L],matt[L][H];
    uint64_t total=0,okcount=0;
    srand((uint32_t)(time(NULL)+clock()));
    while(1){
        total++;
        for(int i=0;i<H;i++){
            uint32_t rnd=rand();
            for(int j=0;j<L;j++){
                mat[i][j]=rnd%C;
                rnd/=C;
            }
        }
        int isok=1;
        for(int i=0;i<H;i++){
            int cons=0,last=-1;
            for(int j=0;j<L;j++){
                matt[j][i]=mat[i][j];
                if(mat[i][j]==last){
                    cons++;
                }else{
                    cons=1;
                    last=mat[i][j];
                }
                if(cons==3)
                    isok=0;
            }
        }
        for(int i=0;i<L;i++){
            int cons=0,last=-1;
            for(int j=0;j<H;j++){
                if(matt[i][j]==last){
                    cons++;
                }else{
                    cons=1;
                    last=matt[i][j];
                }
                if(cons==3)
                    isok=0;
            }
        }
    shit:;
        okcount+=isok;
        if((total&1048575)==0){
            double rate=(double)okcount/(double)total;
            printf("%llu / %llu = %.15lf, est: %.15g\n",okcount,total,rate,pow((double)C,L*H)*rate);
            srand((uint32_t)(time(NULL)+clock()));
        }
    }
    
}
int main(int argc, const char * argv[]) {
    
    wptr=0;
    printf("PLC: %d\n",dg(0,0,0,0));
    needtable=malloc(sizeof(need));
    memset(needtable,0,sizeof(need));
    
    datagen();
    
    //writeneed();
    
    //readneed();
    
//#define LONG_RESULT
#ifdef LONG_RESULT
    ans_t rems[NMOD]={};
    for(int i=0;i<NMOD;i++)
        rems[i]=bejrun(mods[i]);
    printf("ChineseRemainder[{");
    for(int i=0;i<NMOD;i++)
        printf("%u%s",(uint32_t)rems[i],(i+1==NMOD)?"}, {":",");
    for(int i=0;i<NMOD;i++)
        printf("%u%s",(uint32_t)mods[i],(i+1==NMOD)?"}]\n":",");
#else
    printf("%lld\n",bejrun(0LLU));
#endif
    
    //emutest();
    
    return 0;
}
