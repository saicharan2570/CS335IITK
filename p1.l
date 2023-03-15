%{
 #include <fcntl.h>     
 #include <iostream>
 #include <map>
 #include <vector>
 #include <utility>
#include <fstream>
 using namespace std;

 map<pair<string ,string>,pair<int,int>>m;
int order=0;
int line_num=1;
 
%}
DIGIT     [0-9]
ID        [a-zA-Z][a-zA-Z0-9]*
DQ        ["]
SPACE     [ ]*

%%
"{"[^}]*"}" 

[ \t]+

\n   {++line_num;}

  
"."{DIGIT}+  {cout<<yytext<<" "<<" NUMBER IN INVALID IN LINE "<<" "<< line_num<< endl; 

                   }  

{DIGIT}+|{DIGIT}+"."{DIGIT}+([eE][-+]?{DIGIT}+)?|{DIGIT}+([eE][-+]?{DIGIT}+)? { string s=yytext;
   
                     pair < string, string > p2;
                          p2=make_pair(s,"Literal");
                        auto it=m.find(p2);
                        pair<int,int>p21;
                        if(it==m.end())
                        {
                            p21=make_pair(1,order);
                             m.insert({p2,p21});
                             order++;
                        }
                        else
                        {
                            it->second.first++;
                        }
                        }

","|":"|";"|"("|")"|"["|"]"|".." {
                         
                         string s=yytext;
                         
                         pair < string, string > p6;
                          p6=make_pair(s,"Separator");
                        auto it=m.find(p6);
                          pair<int,int>p61;

    
                        if(it==m.end())
                        {
                            
                             p61=make_pair(1,order);
                              m.insert({p6,p61});
                             order++;
                        }
                        else
                        {
                            it->second.first++;
                        }
                        
                     
                                }
                              

"+"|"-"|"*"|"/"|"."|":="|"="|"<>"|"<"|"<="|">="|"^"|">"|"and"|"or"|"not"|"div"|"mod"|"in" {  string s=yytext;
                        
                        pair < string, string > p5;
                          p5=make_pair(s,"Operator");
                        auto it=m.find(p5);
                        pair<int,int>p51;
    
                        if(it==m.end())
                        { 
                            p51=make_pair(1,order);
                             m.insert({p5,p51});
                             order++;
                        }
                        else
                        {
                            it->second.first++;
                        }
                        }


array|begin|case|const|do|downto|else|end|file|for|function|goto|if|label|nil|of|packed|procedure|program|record|repeat|set|then|to|type|until|var|while|with  { string s=yytext;
                        pair < string, string > p4;
                       
                          p4=make_pair(s,"Keyword");
                        auto it=m.find(p4);
                        pair<int,int>p41;
                        if(it==m.end())
                        {
                            p41=make_pair(1,order);
                             m.insert({p4,p41});
                             order++;
                        }
                        else
                        {
                            it->second.first++;
                        }
                        
                                                                                                                                                                             }


{ID} { string s=yytext;
              pair < string, string > p3;
              
                          p3=make_pair(s,"Identifier");
                        auto it=m.find(p3);
                       pair<int,int>p31;
                        if(it==m.end())
                        {
                            p31=make_pair(1,order);
                             m.insert({p3,p31});
                             order++;
                        }
                        else
                        {
                            it->second.first++;
                        }
                        
       }
{DQ}[^}\n]*{DQ} { string s=yytext;
                             
                          pair < string, string > p1;
                          p1=make_pair(s,"String");
                        auto it=m.find(p1);
                        pair<int,int>p11;
                        if(it==m.end())
                        {
                            p11=make_pair(1,order);
                             m.insert({p1,p11});
                             order++;
                        }
                        else
                        {
                            it->second.first++;
                        }
                        
                                  }


.           {cout<<yytext<<" "<<"IS AN ILLEGAL CHARACTER  IN LINE"<<" "<< line_num<< endl; 
                   
               }


  
%%                                
int yywrap(){return 1;}
int main(int argc, char **argv){
 

yyin=fopen(argv[1],"r");
 yylex();

 ofstream csvFile("Result.csv");
 csvFile<<"LEXEME"<<","<<"TOKEN"<<","<<"COUNT"<<endl;
map<pair<string ,string>,pair<int,int>>::iterator it = m.begin();
int temp=0;
while( order>0){

    while(it!=m.end())
    {
        if((*it).second.second==temp)
        {
           csvFile<< (*it).first.first << "," << (*it).first.second <<","<<(*it).second.first<< endl;
           temp++;
           break;
        }
        else
        {
            it++;
        }
    }
    it=m.begin();
       order--;
        
    }

 
fclose(yyin);


return 0;
}
