OBJS = main.o update_Ez.o update_Hx.o udpate_Hy.o
HEADERS = main.h
OPTS = -std=c++1z -O3

main: $(OBJS)
	g++ -o $@ $(OBJS)

%.o: %.cpp $(HEADERS) $(OPTS)
	g++ -c $< $(OPTS)
