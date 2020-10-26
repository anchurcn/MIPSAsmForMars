

int arr[100];
int size=100;
char str_buf[32];

//sort the integer global array 
void sort(){
    int i, key, j; 
    for (i = 1; i < size; i++) { 
        key = arr[i]; 
        j = i - 1; 
  
        /* Move elements of arr[0..i-1], that are 
          greater than key, to one position ahead 
          of their current position */
        while (j >= 0 && arr[j] > key) { 
            arr[j + 1] = arr[j]; 
            j = j - 1; 
        } 
        arr[j + 1] = key; 
    } 
}

//convert hex like "0xFFF" to integer and store in global variable
//pos is index of current integer
void storeHex(char hex[],int pos)
{
    int i=2;// ignore hex tag 0x
    int res=0;
    char byte=0;
    while(byte=hex[i])
    {
        int subres=0;
        if(byte<'A')//num in ascii
        {
            subres=byte-'0';//'0'~'9' to int 0~9
        }
        else//A~F in ascii
        {
            subres=byte-55;//'A'~'F' to int 10~15
        }
        res<<=4;
        res+=subres;
        i++;//move next byte
    }
    arr[pos]=res;
}
//integer to string
void itoa(int num, char* str) //do not consider num<0
{ 
    int i = 0; 
  
    /* Handle 0 explicitely, otherwise empty string is printed for 0 */
    if (num == 0) 
    { 
        str[i++] = '0'; 
        str[i] = '\0'; 
        return str; 
    } 
  
    // Process individual digits 
    while (num != 0) 
    { 
        int rem = num % 10; 
        str[i++] = (rem > 9)? (rem-10) + 'a' : rem + '0'; 
        num = num/10; 
    }
  
    str[i] = '\0'; // Append string terminator 
  
    // Reverse the string 
    reverse(str);
} 
void clr_buf(){
    for(int i=0;i<32;i++)
    {
        str_buf[i]=0;
    }
}
// NOTE:This is NOT traditional C
// argc is argument count
// argv is pointer to argument vector
int main(int argc,char** argv){
    size=argc;
    print("Program arguments:\n");
    for(int i=0;i<argc,i++)
    {
        print(argv[i]);
        if(i!=argc-1)//do not print space after last element
            print(" ")
    }
    print("\n");
    print("\n");
    for(int i=0;i<size;i++)
    {
        storeHex(argv[i]++,i);
    }
    print("Integer values:\n");
    for(int i=0;i<size,i++)
    {
        clr_buf();
        itoa(arr[i],str_buf);
        print(str_buf);
        if(i!=size-1)//do not print space after last element
            print(" ")
    }
    print("\n");
    print("\n");
    sort();
    print("Program arguments:\n");
    for(int i=0;i<size,i++)
    {
        clr_buf();
        itoa(arr[i],str_buf);
        print(str_buf);
        if(i!=size-1)//do not print space after last element
            print(" ")
    }
    print("\n");
    print("\n");
    return 0;
}