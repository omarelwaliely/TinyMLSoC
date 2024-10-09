volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
void delay(int count)
{
    volatile i = count;
    while(i>0)
    {
        i--;
    }
}

int main() {

    *gpio_oe_A = 0xFFFFFFFF;
    unsigned int data_A = 0xFFFF;
    while (1) { 
        *gpio_data_A = data_A;
        delay(100000);
        data_A = data_A +1;
        data_A = data_A % 7;
    }

    return 0;
}