#include <cuda_runtime.h>
#include <stdio.h>
#include <cuda.h>
#include <iostream>

__global__ void checkIndex( void ){
    /*std::cout << "threadIdx : " << threadIdx.x << " " << threadIdx.y << " " << threadIdx.z << std::endl
    << "blockIdx : " << blockIdx.x << " " << blockIdx.y << " " << blockIdx.z << std::endl
    << "blockDim : " << blockDim.x << " " << blockDim.y << " " << blockDim.z << std::endl
    << "gridDim : " << gridDim.x << " " << gridDim.y << " " << gridDim.z << std::endl;*/
    printf("threadIdx: (%d, %d, %d) blockIdx: (%d, %d, %d) blockDim: (%d, %d, %d) "
    "gridDim: (%d, %d, %d)\n", threadIdx.x, threadIdx.y, threadIdx.z,
                                blockIdx.z, blockIdx.y, blockIdx.z,
                                blockDim.x, blockDim.y, blockDim.z,
                                gridDim.x, gridDim.y, gridDim.z );
}

int main( int argc, char** argv ){

    int nElem( 6 );

    dim3 block(3);
    dim3 grid( ( nElem + block.x - 1) / block.x );

    std::cout << "grid_x : " << grid.x << " grid_y : " << grid.y << " grid_z : " << grid.z << std::endl;
    std::cout << "block_x : " << block.x << " block_y : " << block.y << " block_z : " << block.z << std::endl;

    checkIndex<<<grid, block>>> ();

    cudaDeviceReset();

    return 0;
}