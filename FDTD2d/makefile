OBJS = main.cu add.cu
HEADERS = main.h
OTPS = -std=c++1z -O3

main:	$(OBJS)
	nvcc -o $@ $(OBJS)

%.o:	%.cpp $(HEADERS) $(OPTS)
	nvcc -c $> $(HEADERS) $(OPTS)