#include <stdio.h>
#include <time.h>

#define L 3
#define N (L*L)
#define S (L*L*L*L)

// #define LEAST_CAND_FIRST

const char* resdesc[]={
  "No solution",
  "Unique solution",
  "Multiple solution"
};

int freelist[S];
int nfree;
int resstate; // 0: not yet, 1: one found 
unsigned long long btcount,btcountfs;

int rowfree[N],colfree[N],blkfree[N];
int atrow[S],atcol[S],atblk[S];

char a[S+1];

void init(){
  int x,y;
  for(y=0;y<N;y++)
    for(x=0;x<N;x++){
      int g=y*N+x;
      atrow[g]=y;
      atcol[g]=x;
      atblk[g]=(y/L)*L+(x/L);
    }
}

unsigned int bitcount(unsigned int i){
  i = i - ((i >> 1) & 0x55555555);
  i = (i & 0x33333333) + ((i >> 2) & 0x33333333);
  i = (i + (i >> 4)) & 0x0f0f0f0f;
  i = i + (i >> 8);
  i = i + (i >> 16);
  return i & 0x3f;
}

int dg(int ifree){
  btcount++;
  if(ifree==nfree){
    if(resstate==0){
      btcountfs=btcount;
      resstate=1;
      return 1;
    }
    else if(resstate==1){
      resstate=2;
      return 2;
    }
  }else{
    #ifdef LEAST_CAND_FIRST
    int ifl;
    int ig;
    int freemask;
    int mincand=N+1,mincandi;
    
    for(ifl=ifree;ifl<nfree;ifl++){
      int iflg=freelist[ifl];
      int iflgfreemask=
        rowfree[atrow[iflg]]&
        colfree[atcol[iflg]]&
        blkfree[atblk[iflg]];
      int ncand=bitcount(iflgfreemask);
      if(ncand<mincand){
        mincand=ncand;
        mincandi=ifl;
        ig=iflg;
        freemask=iflgfreemask;
      }
    }
    // the free grid pos is stored in `ig`. later to restore it into `freelist[mincandi]`.
    freelist[mincandi]=freelist[ifree];
    
    #else // the simple, traditional, naive, standard way
    int ig=freelist[ifree];
    int freemask=
      rowfree[atrow[ig]]&
      colfree[atcol[ig]]&
      blkfree[atblk[ig]];
    #endif
    
    int hasres=0;
    int g;
    for(g=0;g<N;g++){
      int mask=1<<g;
      if(freemask&mask){
        rowfree[atrow[ig]]&=~mask;
        colfree[atcol[ig]]&=~mask;
        blkfree[atblk[ig]]&=~mask;
        
        int restype=dg(ifree+1);
        if(restype==2) // just die quickly, no matter what's left.
          return 2;
        else if(restype==1){ // fill in the string only when single solution.
          a[ig]='1'+g;
          hasres=1;
          //return 1; // stop once one solution found. the conclution string will be wrong.
        }
        
        rowfree[atrow[ig]]|=mask;
        colfree[atcol[ig]]|=mask;
        blkfree[atblk[ig]]|=mask;
      }
    }
    #ifdef LEAST_CAND_FIRST
    freelist[mincandi]=ig;
    #endif
    return hasres;
  }
}

int solve(){
  int ig,in;
  int g;
  nfree=0;
  resstate=0;
  btcount=0;
  btcountfs=0;
  
  printf("Solving:  %s\n",a);
  for(in=0;in<N;in++){
    rowfree[in]=(1<<N)-1;
    colfree[in]=(1<<N)-1;
    blkfree[in]=(1<<N)-1;
  }
  for(ig=0;ig<S;ig++){
    char c=a[ig];
    if(c=='.'){
      freelist[nfree++]=ig;
    }else{
      g=c-'1';
      int mask=1<<g;
      if((rowfree[atrow[ig]]&mask)==0)
        return 0;
      if((colfree[atcol[ig]]&mask)==0)
        return 0;
      if((blkfree[atblk[ig]]&mask)==0)
        return 0;
      rowfree[atrow[ig]]&=~mask;
      colfree[atcol[ig]]&=~mask;
      blkfree[atblk[ig]]&=~mask;
    }
  }
  
  clock_t ts=clock();
  dg(0);
  clock_t te=clock();
  
  printf("btcount:   %llu, %s, %g sec.\n",btcount,resdesc[resstate],((double)(te-ts))/CLOCKS_PER_SEC);
  if(resstate==1 || resstate==2){
    printf("btcountfs: %llu\n", btcountfs);
    if(resstate==1)
      printf("Solution: %s\n",a);
  }
  puts("");
  return resstate;
}

int main(){
  init();
  // freopen("puzzles.txt","r",stdin);
  #ifdef LEAST_CAND_FIRST
  printf("using Least Candidates First strategy\n");
  #else
  printf("using Naive strategy\n");
  #endif
  while(1){
    int ng=0;
    int gc;
    while(ng<S){
      gc=getchar();
      if(gc>='1'&&gc<='9'){
        a[ng++]=gc;
      }else if(gc=='0'||gc=='.'){
        a[ng++]='.';
      }else if(gc<0){
        return ng;
      }
      if(ng==S){
        a[S]='\0';
        solve();
      }
    }
  }
}
