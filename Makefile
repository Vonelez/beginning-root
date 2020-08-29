CXX = g++

DEBUG = -g
RELEASE = -O2
EXEC_TYPE = ${DEBUG}

CXXFLAGS = -Wall ${EXEC_TYPE} $(shell root-config --cflags)

PATH_ITS = -I./includes
INCPATH = ${PATH_ITS}

OTHER_FLAGS = -lm -lstdc++ -std=c++11 -lMinuit
LDFLAGS = ${OTHER_FLAGS} $(shell root-config --glibs)

EXEC = analysis

SOURCE_DIR = codes
SRC = main.cpp $(SOURCE_DIR)/read_tree.cpp $(SOURCE_DIR)/fill_hist.cpp $(SOURCE_DIR)/fit_func.cpp

BUILD_DIR = build

OBJ = $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(SRC))

all: $(EXEC)
$(EXEC): ${OBJ}
	$(CC) -o $(BUILD_DIR)/$@ $^ $(LDFLAGS)
$(OBJ): | ${BUILD_DIR}
$(BUILD_DIR):
	@mkdir -p -v $@
$(BUILD_DIR)/%.o : %.cpp
	@mkdir -p -v $(@D)
	$(CXX) $(CXXFLAGS) $(INCPATH) -c $<  -o $@

clean:
	rm -rf $(BUILD_DIR) 
