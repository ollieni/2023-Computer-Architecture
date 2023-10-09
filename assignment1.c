#include <stdio.h>
#include <stdint.h>

uint16_t count_leading_zeros(uint64_t x, int input_size)
{
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);
    x |= (x >> 32);

    /* count ones (population count) */
    x -= ((x >> 1) & 0x5555555555555555 );
    x = ((x >> 2) & 0x3333333333333333) + (x & 0x3333333333333333 );
    x = ((x >> 4) + x) & 0x0f0f0f0f0f0f0f0f;
    x += (x >> 8);
    x += (x >> 16);
    x += (x >> 32);

    return (input_size - (x & 0x7f));
}

int priority_encoder_4bit(int leading_zero, int input_size) {
    if(leading_zero<0)
    {
        printf("wrong input");
        return 0;
    }
    else
    {
        return (input_size -1 -(la));
    }
}

int main() {
    int input;
    int input_size;
    int leading_zero = 0;
    int priority = 0;
    printf("Enter a  number : ");
    scanf("%4d", &input);
    printf("Enter a  input size : ");
    scanf("%4d", &input_size);
    leading_zero = count_leading_zeros(input,input_size);
    printf("%d\n",leading_zero);
    priority = priority_encoder_4bit(leading_zero, input_size);
    printf("%d\n",priority);
    return 0;
}