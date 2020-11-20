#include <stdio.h>
#include <iostream>

int main( void ){

    int nElem = 1024;

    dim3 block(1024);
    dim3 grid( ( nElem + block.x - 1 ) / block.x );
    std::cout << "grid.x : " << grid.x << "  block.x : " << block.x << std::endl;

    // ブロックをリセット //
    block.x = 512;
    grid.x = (nElem + block.x - 1) / block.x;
    std::cout << "grid.x : " << grid.x << "  block.x : " << block.x << std::endl;

     // ブロックをリセット //
    block.x = 256;
    grid.x = (nElem + block.x - 1) / block.x;
    std::cout << "grid.x : " << grid.x << "  block.x : " << block.x << std::endl;

     // ブロックをリセット //
    block.x = 128;
    grid.x = (nElem + block.x - 1) / block.x;
    std::cout << "grid.x : " << grid.x << "  block.x : " << block.x << std::endl;

    // デバイスをリセット //
    cudaDeviceReset();

    return(0);

}