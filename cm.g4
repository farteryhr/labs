//中文数学描述语法，参照https://zhuanlan.zhihu.com/p/23838178
//ANTLR4, 注意 -encoding UTF-8
grammar cm;

exprList: (expr)*;

expr
: ID '其' expr
| ('正'|'负') expr
| expr '虚'
| expr '的' ('平'|'立'|expr '次') ('方'|'方根')
| expr '的' ('相反数'|'共轭'|'绝对值'|'模'|'阶乘'|'常用对数'|'自然对数')
| expr '的' '反'? '双曲'? ('正'|'余')('弦'|'切'|'割')
| expr '的以' expr '为底的对数'
| expr '的' ID '趋向于' expr '的极限'
| expr '的关于' ID '从' expr '到' expr '的总和'
| num '倍' expr
| expr ('乘'|'除以') expr
| expr ('分之') expr
| expr ('加'|'减') expr
| expr '在' expr '的' ('排列'|'组合')

| '关于' expr '结果'

//| expr '与' expr '之' ('和'|'差'|'积'|'商')

//| expr ('与'|'加') expr '之和'
//| expr ('与'|'减') expr '之差'
//| expr ('与'|'乘') expr '之积'
//| expr ('与'|'除') expr '之商'

//| '关于' expr '加' expr '之和'
//| '关于' expr '减' expr '之差'
//| '关于' expr '乘' expr '之积'
//| '关于' expr '倍' expr '之积'
//| '关于' expr '除以' expr '之商'
//| '关于' expr '分之' expr '之商'

| expr ('等于'|'不等于'|'大于'|'小于'|'大于等于'|'小于等于'|'约等于') expr
| num
| CONST
| ID
;

DIGIT: ('一'|'二'|'三'|'四'|'五'|'六'|'七'|'八'|'九');
ZDIGIT: ('一'|'二'|'三'|'四'|'五'|'六'|'七'|'八'|'九'|'零');

n1: DIGIT;
n01: '零' n1 |;
nm1: n1;
nm01: '零' n1;

n2: DIGIT? '十' (n1 | );
n02: '零' n2 | n01;
nm2: n2 | nm01;
nm02: '零' n2 | nm01;

n3: DIGIT '百' (n2 | n01);
n03: '零' n3 | n02;
nm3: n3 | '零' nm2;
nm03: '零' n3 | nm02;

n4: DIGIT '千' (n3 | n02);
n04: '零' n4 | n03;
nm4: n4 | '零' nm3;
nm04: '零' n4 | nm03;

ns4: n4 | n3 | n2 | n1;
ne4: n4 | n03;

n08: '零' n8 | n04;
n8: ns4 '万' ne4;
ne8: nm4 '万' ne4 | n04;

n012: '零' n12 | n08;
n12: ns4 '亿' ne8;
ne12: nm4 '亿' ne8 | n08;

n016: '零' n16 | n012;
n16: ns4 '兆' ne12;
ne16: nm4 '兆' ne12 | n012;

n020: '零' n20 | n16;
n20: ns4 '京' ne16;
ne20: nm4 '京' ne16 | n016;

ns20: ns4 | n8 | n12 | n16 | n20;

//对于数字解析，ANTLR运行时会报告 attempting full context, context sensitivity，
//但是似乎都能正确解析。这个数字解析太鬼畜，待修订。
num: ('零' | ns20) ('点' ZDIGIT+)?;

CONST: '圆周率' | '自然对数的底' | (ID '常数') | '无穷';
WS: [ \t\n\r] -> skip;
  
ID: ('甲'|'乙'|'丙'|'丁'|'子'|'丑'|'寅'|'卯'|'天'|'地'|'人'|'畜') | ('准') ID;
