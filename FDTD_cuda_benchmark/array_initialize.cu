#define _USE_MATH_DEFINES

void array_initialize( float* array, int size )
{
    for( int i = 0; i < size; i++ ) array[i] = 0.0;
}