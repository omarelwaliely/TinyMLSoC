volatile unsigned int* APB = (volatile unsigned int *) 0x60000000;
volatile unsigned int* GPIO_DIR = (volatile unsigned int*) 0x60010004;
volatile unsigned int* GPIO_DATA = (volatile unsigned int*) 0x60010000;
int main() {     

    *GPIO_DIR = 0xFFFFFFFF;
    volatile unsigned int count = 0;
    while (1) {
        *GPIO_DATA = count;
        count +=1;
    }
    
    return 0;
    
}
