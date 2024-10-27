volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
unsigned int count = 500000;
void delay(void)
{
    while(count>0)
    {
        count--;
    }
}

int main() {

    *gpio_oe_A = 0xFFFFFFFF;

    unsigned int data_A = 0xFFFF;
    while (1) { 

        if((data_A & 0b111) == 0) {
            data_A = 0xFFFF;  
        } else {
            data_A = data_A << 1;  
        }
        *gpio_data_A = data_A;

        delay();
        
    }

    return 0;
}