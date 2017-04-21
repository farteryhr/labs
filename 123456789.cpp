#include <cstdio>
#include <cmath>
#include <map>
#include <set>

typedef long double numt;

struct node{
	numt num;
	const node *l,*r;
	char optype,opneg;
};
bool operator< (const node& a, const node& b){
	return a.num<b.num;
}

//problem size. 9 with +-*/^ takes 1~2 gb ram and several minutes.
#define L 9

typedef std::set<node> mapt ;
mapt m[L][L+1];

const numt cmnfac=2*2*2*3*3*5*7;
const char numstr[]="123456789";

//initial concatenation
node leafnode(int l,int r){
	node n;
	n.num=0.0l;
	for(int i=l;i<r;i++){
		n.num=n.num*10.0l+(numt)(numstr[i]-'0');
	}
	n.l=n.r=NULL;
	n.optype=0;
	n.opneg=0;
	return n;
}
void printnode(const node& n,bool brkt){
	if(n.optype==0){
		if(n.num<0.0l){
			printf("(%.10lg)",(double)n.num);
		}else{
			printf("%.10lg",(double)n.num);
		}
	}else{
		if(n.optype==4){
			printf(" +");
		}
		if(brkt || n.optype==4){
			putchar('(');
		}
		printnode(*n.l,n.l->optype>0 && n.l->optype < n.optype);
		if(n.optype==1){
			if(n.opneg==0){
				printf(" + ");
			}else{
				printf(" - ");
			}
		}else if(n.optype==2){
			if(n.opneg==0){
				printf(" * ");
			}else{
				printf(" / ");
			}
		}else if(n.optype==3){
			// right associativity
			printf(" ^ ");
		}else if(n.optype==4){
			printf(" +\"\"+ ");
		}
		printnode(*n.r,n.r->optype>0 && n.r->optype < n.optype);
		if(brkt || n.optype==4){
			putchar(')');
		}
		//printf(" /*%.10lg*/",(double)n.num);
	}
}
void insertnodup(mapt& m,const node& n){
	mapt::iterator find=m.find(n);
	if(find==m.end()){
		m.insert(n);
	}else{
		return;
		printf("dup %.17lg ",(double)n.num);
		printnode(*find,false);
		printf(" = ");
		printnode(n,false);
		printf("\n");
	}
}
numt idigits(numt n){
	n=roundl(n);
	if(n<10){
		return 10.0l;
	}else if(n<100.0l){
		return 100;
	}else if(n<1000.0l){
		return 1000;
	}else if(n<10000.0l){
		return 10000;
	}else if(n<100000.0l){
		return 100000;
	}
	return 0;
}

void numfix(node& n){
	//try to fix FP errors.
	//may do wrong things with extremely small probability.
	//needs CAS to for absolute corectness.
	if(fabsl(n.num-roundl(n.num))<1e-15l){
		n.num=roundl(n.num);
	}else if(fabsl(n.num*cmnfac-roundl(n.num*cmnfac))<1e-12l){
		n.num=roundl(n.num*cmnfac)/cmnfac;
	}
}
int main(){
	//ensure long double
	if(1){
		printf("%d %.30lg %.30lg\n",
			sizeof(numt),
			(double)(((-1.0)-2.0)/((3.0+4.0)/5.0+6.0-7.0)+8.0),
			(double)(((-1.0l)-2.0l)/((3.0l+4.0l)/5.0l+6.0l-7.0l)+8.0l)
		);
	}
	
	for(int i=1;i<=L;i++){
		for(int j=0;j+i<=L;j++){
			printf("width:%d offset:%d\n",i,j);
			mapt& out=m[j][j+i];
			node n;
			//if(i==1){ //only single digits
				n=leafnode(j,j+i);
				insertnodup(out,n);
				if(j==0 && n.num!=0.0l){
					//only negate the first number
					//for positive initials and positive desired answers
					//negation sign can be transformed out of brackets
					n.num=-n.num;
					insertnodup(out,n);
				}
			//}
			for(int k=1;k<=i-1;k++){
				printf("split:%d len-a:%d len-b:%d\n",k,m[j][j+k].size(),m[j+k][j+i].size());
				for(mapt::iterator ita=m[j][j+k].begin();ita!=m[j][j+k].end();ita++){
					for(mapt::iterator itb=m[j+k][j+i].begin();itb!=m[j+k][j+i].end();itb++){
						
						const node &na=*ita,&nb=*itb;
						n.l=&na;
						n.r=&nb;
						if(nb.optype!=1){
							n.optype=1;
							if(nb.optype!=0 || nb.num>=0){
								n.opneg=0;
								n.num=na.num+nb.num;
								if(fabsl(n.num-roundl(n.num))<1e-15l || 
									fabsl(n.num-roundl(n.num))>1e-3l){
									//numfix(n);
									insertnodup(out,n);
								}
							}
							if(nb.optype!=0 || nb.num>=0){
								n.opneg=1;
								n.num=na.num-nb.num;
								if(fabsl(n.num-roundl(n.num))<1e-15l || 
									fabsl(n.num-roundl(n.num))>1e-3l){
									//numfix(n);
									insertnodup(out,n);
								}
							}
						}
						if(nb.optype!=2){
							n.optype=2;
							n.opneg=0;
							n.num=na.num*nb.num;
							if(fabsl(n.num)<1e10l){ //pruning
								numfix(n);
								insertnodup(out,n);
							}
							#if 0 //division
							n.opneg=1;
							n.num=na.num/nb.num;
							if(n.num==n.num && fabsl(n.num)<1e10l){
								numfix(n);
								insertnodup(out,n);
							}
							#endif
						}
						#if 1 //power, produces many useless nodes with division enabled 
						if(na.optype!=3 && // (a^b)^c=a^(b*c)
							na.num >= 0 &&
							//nb.num >= 0 &&
							//fabsl(roundl(na.num)-na.num)<1e-15l &&
							//fabsl(roundl(nb.num)-nb.num)<1e-15l &&
							true){
							n.optype=3;
							n.opneg=0;
							//n.num=powl(roundl(na.num),roundl(nb.num));
							n.num=powl(na.num,nb.num);
							if(n.num==n.num && fabsl(n.num)<1e10l && fabsl(n.num)>1e-3l){
								numfix(n);
								insertnodup(out,n);
							}
						}
						#endif
						#if 0 //concatenation, only integers
						if(nb.optype!=4 &&
							na.num >= 0 &&
							nb.num >= 0 &&
							(na.optype!=0 || nb.optype!=0) &&
							fabsl(roundl(na.num)-na.num)<1e-15l &&
							fabsl(roundl(nb.num)-nb.num)<1e-15l &&
							na.num<10000.0l &&
							nb.num<10000.0l){
							n.optype=4;
							n.opneg=0;
							n.num=roundl(na.num)*idigits(roundl(nb.num))+
								roundl(nb.num);
							//numfix(n);
							insertnodup(out,n);
						}
						#endif
					}	
				}
			}
		}
	}
	mapt& ans=m[0][L];
	printf("OK! total %d\n",ans.size());
	if(0){ //list all
		for(mapt::iterator it=ans.begin();it!=ans.end();it++){
			printf("res %.17lg = ",(double)(it->num));
			printnode(*it,false);
			printf("\n");
		}
	}
	if(1){ //do something meaningful
		double din=0.0;
		double prec=1e-15;
		node ntmp;
		if(1){ //enumerate integer results
			for(int i=0;;i++){ 
				bool res=false;
				din=(numt)i;
				ntmp.num=din-1e-15;
				mapt::iterator it=ans.lower_bound(ntmp);
				for(;it!=ans.end() && fabsl(it->num-din)<=prec;it++){
					//printnode(*it,false);
					//printf(" = %.17lg\n",(double)(it->num));
					res=true;
					break; // get rid of multiple answers due to FP error
				}
				if(!res){
					printf("%d no solution!\n",i);
					break;
				}
			}
		}
		if(1){ //interactive
			while(true){
				printf("enter a desired number:");
				scanf("%lf",&din);
				bool res=false;
				prec=1e-15;
				
				while(!res){
					ntmp.num=din-prec;
					mapt::iterator it=ans.lower_bound(ntmp);
					for(;it!=ans.end() && fabsl(it->num-din)<=prec;it++){
						printnode(*it,false);
						printf(" = %.17lg\n",(double)(it->num));
						res=true;
					}
					prec*=2;
				}
			}
		}
	}
	return 0;
}

// hint of a step in advance:
// only calculate until i<=L-1, for a desired answer,
// enumerate operator, enumerate splitting point (aka. the last done operator)
// for each result in one side (the side having less paitial results),
// find the inverse about that operator (x OP a = b, a OP x = b)
// look it up in the other side.
