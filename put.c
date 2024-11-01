int ft_isdigit(char s)
{
    return (s >= '0' && s <= '9');
}
int is_whitespace(char s)
{
    return (s >= 9 && s <= 13 || s == 32);
}

int ft_atoi(char *s)
{
    int i = 0, res = 0 , sg = 1;
    
    while(is_whitespace(s[i]) && s[i])
        i++;

    if(s[i] == '-') {
        sg = -1;
        i++;
    } else if (s[i] == '+')
        i++;

    while (s[i] && ft_isdigit(s[i]))
        res = (res * 10) + s[i++] - '0';
    

    return ( res * sg);    
}   
#include <stdio.h>
int main()
{
    printf("%d\n" , ft_atoi("                   -123"));
}