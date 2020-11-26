OBJS = add_Jz.o main.o update_Ez.o update_Hx.o update_Hy.o
HEADERS = main.h
OTPS = -std=c++1z -O3

main:	$(OBJS)
	nvcc -o $@ $(OBJS)

%.o:	%.cu $(HEADERS) $(OPTS)
	nvcc -c $< $(OPTS)