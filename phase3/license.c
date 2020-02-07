#include <stdlib.h>
#include <stdio.h>

long code[] = 
{
    0x71686367, 0x00000000, 0x00000000, 0xa3bfc2af, 0xd2ab1f05, 0xda13f110
};

int main()
{
    FILE *fp = fopen("./license.txt","wb");
    if(fp == NULL) 
    {
        printf("Input error!\n");
        return 1;
    } else {
        fwrite(code, sizeof(long), 6, fp);
        fclose(fp);
    }
    return 0;
}
