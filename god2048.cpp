#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <stdint.h>
#include <conio.h>

#define S 3
#define SS 9
#define SSS (1<<SS)
#define N (SS+1)

#define M_POW_0(x) (1)
#define M_POW_1(x) (x)
#define M_POW_2(x) (x*x)
#define M_POW_3(x) (x*x*x)
#define M_POW_4(x) (x*x*x*x)
#define M_POW_5(x) (x*x*x*x*x)
#define M_POW_6(x) (x*x*x*x*x*x)
#define M_POW_7(x) (x*x*x*x*x*x*x)
#define M_POW_8(x) (x*x*x*x*x*x*x*x)
#define M_POW_9(x) (x*x*x*x*x*x*x*x*x)
#define M_EXPAND(...) __VA_ARGS__
#define M_POW_(x,y) M_EXPAND(M_POW_ ## y) (x)
#define M_POW(x,y) M_POW_(M_EXPAND(x),y)

#define M_REPEAT_(N, X) M_EXPAND(M_REPEAT_ ## N)(X)
#define M_REPEAT(N, X) M_REPEAT_(M_EXPAND(N), X)

typedef struct {
	int g[S];
} Lin;
typedef struct {
	Lin l[S];
} Mat;
typedef uint32_t Pak;

int isum=0;
int stat[SSS]={0};
int count=0;
void dgstat(int y,int x){
	if(isum>=SSS)
		return;
	if(y==S){
		if(isum<SSS){
			stat[isum]++;
			count++;
		}
		return;
	}
	for(int xh=-1;xh<SS;xh++){
		if(xh!=-1){
			isum+=(1<<xh);
		}
		if(x+1==S || xh==-1){
			dgstat(y+1,0);
		}else{
			dgstat(y,x+1);
		}
		if(xh!=-1){
			isum-=(1<<xh);
		}
	}
}

Pak lpack(Lin* l){
	Pak ret=0U,tim=1U;
	for(int xh=0;xh<S;xh++){
		ret+=tim*(l->g[xh]+1);
		tim*=N;
	}
	return ret;
}
Lin lunpack(Pak p){
	Lin ret;
	for(int xh=0;xh<S;xh++){
		ret.g[xh]=(p%N);
		p/=N;
	}
	return ret;
}
Pak mpack(Mat* m){
	Pak ret=0U,tim=1U;
	for(int xh=0;xh<S;xh++){
		ret+=tim*lpack(&(m->l[xh]));
		tim*=M_POW(N,S);
	}
	return ret;
}
Mat munpack(Pak p){
	Mat ret;
	for(int xh=0;xh<S;xh++){
		ret.l[xh]=lunpack(p%M_POW(N,S));
		p/=M_POW(N,S);
	}
	return ret;
}
void mprint(Mat* m){
	for(int xhy=0;xhy<S;xhy++){
		for(int xhx=0;xhx<S;xhx++){
			if(m->l[xhy].g[xhx]<0){
				putchar('.');
			}else{
				putchar('0'+(m->l[xhy].g[xhx]));
			}
		}
		putchar('\n');
	}
}

typedef uint16_t es_t;
const double estimes = 16.0;
typedef double ext_es_t;
typedef es_t(*estable_t)[M_POW(N, SS)];
estable_t est = NULL;
#define es (*est)

int mapmove(Mat* m, int dire){
	if(dire&1){
		for(int xhy=0;xhy<S;xhy++){
			for(int xhx=0;xhx<xhy;xhx++){
				int t=m->l[xhy].g[xhx];
				m->l[xhy].g[xhx]=m->l[xhx].g[xhy];
				m->l[xhx].g[xhy]=t;
			}
		}
	}
	if(dire&2){
		for(int xhy=0;xhy<S;xhy++){
			for(int xhx=0;xhx*2<S-1;xhx++){
				int t=m->l[xhy].g[xhx];
				m->l[xhy].g[xhx]=m->l[xhy].g[S-1-xhx];
				m->l[xhy].g[S-1-xhx]=t;
			}
		}
	}
	int moved=0,score=0;
	for(int xhy=0;xhy<S;xhy++){
		Lin* l=&(m->l[xhy]);
		int w=0,r=1;
		while(r<S){
			if(l->g[r]<0){
				
			}else{
				if(l->g[w]<0){
					if(l->g[r]>=0){
						l->g[w]=l->g[r];
						l->g[r]=-1;
						moved=1;
						score = (int)(1*estimes);
					}
				}else{
					if (l->g[r] >= 0){
						if (l->g[w] == l->g[r]){
							l->g[w]++;
							l->g[r] = -1;
							//score+=(1<<l->g[w]);
							score = (int)(1 * estimes);
							w++;
							moved = 1;
						}else{
							w++;
							if (w < r){
								l->g[w] = l->g[r];
								l->g[r] = -1;
								score = (int)(1 * estimes);
								moved = 1;
							}
						}
					}
				}
			}
			r++;
		}
	}
	if(moved==0){
		return -1;
	}else{
		return score;
	}
}

es_t dgsolve(Mat *m){
	Pak p=mpack(m);
	//printf("pack:%u\n",p);
	if (p >= (M_POW(N, SS))){
		return 0;
	}
	if(es[p]==0){
		int spawn=0;
		ext_es_t spawnes=0;
		for(int xhy=0;xhy<S;xhy++){
			for(int xhx=0;xhx<S;xhx++){
				if(m->l[xhy].g[xhx]<0){
					spawn++;
					Mat spawnm=*m;
					spawnm.l[xhy].g[xhx]=0;
					ext_es_t maxes = 0, movedes;
					int moveways = 0;
					for(int xhd=0;xhd<4;xhd++){
						Mat newm=spawnm;
						int score=mapmove(&newm,xhd);
						if(score>=0){
							moveways++;
							movedes = (ext_es_t)score + dgsolve(&newm);
							if(movedes>maxes){
								maxes=movedes;
							}
						}
					}
					spawnes+=maxes;
					
					//mprint(&spawnm);
					//printf("maxes:%g from %d ways to move\n", maxes / estimes, moveways);
				}
			}
		}
		if(spawn==0){
			es[p] = (es_t)-1;
		}else{
			spawnes/=spawn;
			if(spawnes==0){
				es[p] = (es_t)-1;
			}else{
				es[p]=(es_t)spawnes;
			}
		}
		//mprint(m);
		//printf("es:%g from %d spawn pos\n",es[p]/estimes,spawn);
	}
	//getchar();
	if(es[p]==(es_t)-1){
		return 0;
	}else{
		return es[p];
	}
}

void gen(){
	Mat m =
#if S==2
	{ { { -1, -1 }, { -1, -1 } } }
#elif S==3
	{{ { -1, -1, -1 }, { -1, -1, -1 }, { -1, -1, -1 } }}
#endif
	//{{{1,1,3,3},{0,0,0,0},{0,-1,-1,0},{0,0,0,0}}}
	;
	mapmove(&m, 3);
	mprint(&m);
	printf("%u %u %u\n", N, SS, sizeof(es_t)*M_POW(N, SS));


	est = (estable_t)malloc(sizeof(es_t)*M_POW(N, SS));
	if (est != NULL){
		memset(es, 0u, sizeof(es_t)*M_POW(N, SS));
		dgsolve(&m);
		printf("%g\n", es[0] / estimes);
	}
	
}

void test(){
	Mat m =
#if S==2
	{ { { 1, -1 }, { -1, -1 } } }
#elif S==3
	{{ { 1, 1, -1 }, { 0, 0, -1 }, { 1, 1, -1 } }}
#endif
	;
	int moveways = 0;
	for (int xhd = 0; xhd<4; xhd++){
		Mat newm = m;
		int score = mapmove(&newm, xhd);
		if (score >= 0){
			moveways++;
		}
	}
	printf("moveways %d\n", moveways);
	mapmove(&m, 2);
	mprint(&m);
}

void inspect(){
	Mat m =
#if S==2
	{ { { 1, -1 }, { -1, -1 } } }
#elif S==3
	{{ { 1, 1, -1 }, { 0, 0, -1 }, { 1, 1, -1 } }}
#endif
	;
	int cury=0, curx=0;
	int oper;
	while (1){
		for (int xhy = 0; xhy < S; xhy++){
			for (int xhx = 0; xhx < S; xhx++){
				putchar((xhx == curx&&xhy == cury) ? '[' : ' ');
				putchar((m.l[xhy].g[xhx] < 0) ? '.' : ('0' + m.l[xhy].g[xhx]));
				putchar((xhx == curx&&xhy == cury) ? ']' : ' ');
			}
			putchar('\n');
		}
		ext_es_t maxes = 0, movedes;
		int moveways = 0, bestd=0;
		for (int xhd = 0; xhd<4; xhd++){
			Mat newm = m;
			int score = mapmove(&newm, xhd);
			if (score >= 0){
				moveways++;
				movedes = (ext_es_t)score + dgsolve(&newm);
				if (movedes>maxes){
					maxes = movedes;
					bestd = xhd;
				}
			}
		}
		printf("best: %c, %g\n", "lurd"[bestd],maxes / estimes);

		oper = _getch();
		switch (oper){
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
			m.l[cury].g[curx] = oper - '0'; break;
		case '.':
			m.l[cury].g[curx] = -1; break;
		case 'i':
			if (cury > 0)cury--; break;
		case 'k':
			if (cury < S - 1)cury++; break;
		case 'j':
			if (curx > 0)curx--; break;
		case 'l':
			if (curx < S - 1)curx++; break;
		case 'm':
			mapmove(&m, bestd);
			struct{ int x, y; } empty[SS];
			int nempty = 0;
			for (int xhy = 0; xhy < S; xhy++){
				for (int xhx = 0; xhx < S; xhx++){
					if (m.l[xhy].g[xhx] < 0){
						empty[nempty].y = xhy;
						empty[nempty].x = xhx;
						nempty++;
					}
				}
			}
			if (nempty != 0){
				int choose = rand() % nempty;
				m.l[empty[choose].y].g[empty[choose].x] = 0;
			}
			break;
		}
	}
}
int main(){
	/*
	dgstat(0,0);
	for(int xh=0;xh<SSS;xh++){
		printf("%d:%d\t",xh,stat[xh]);	
	}
	printf("\ncount:%d\n",count);
	*/
	
	//test();
	gen();
	inspect();
	system("pause");
	free(est);
	return 0;
}
