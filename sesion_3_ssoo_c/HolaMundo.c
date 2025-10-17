#include <stdio.h>
int main(int argc,char *argv[]){

	char caracter=getchar();
	int noLineas=0;
	while(caracter != EOF ){ //Usar ctrl >
	   if(caracter=='\n'){
		noLineas++;
	   }
	   caracter=getchar();
	}
	printf("Has introducido %d lineas \n",noLineas);
	return 0;
}
/*Comentario*/
//Comentario
