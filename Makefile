CC = gcc

BUILD_DIR = build

CFLAGS = -Wall -Wextra -std=c11 -Iinclude
LFLAGS = -lcjson
TARGET = $(BUILD_DIR)/graphgen

SRC_DIR = src
OBJ_DIR = $(BUILD_DIR)/obj

SRC_FILES = $(notdir $(wildcard $(SRC_DIR)/*.c))
OBJ_FILES = $(SRC_FILES:.c=.o)

SRC = $(addprefix $(SRC_DIR)/,$(SRC_FILES))
OBJ = $(addprefix $(OBJ_DIR)/,$(OBJ_FILES))


$(TARGET) : $(OBJ_DIR) $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LFLAGS)

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.c 
	$(CC) $< -o $@ -c $(CFLAGS)

.SILENT: $(OBJ_DIR)
$(OBJ_DIR):
	mkdir $(OBJ_DIR) -p


.PHONY: clean
clean:
	rm $(OBJ_DIR) -rf

.PHONY: run
.SILENT: run
run:
	./$(TARGET)

.PHONY: debug
debug:
	@echo SRC_F: $(SRC_FILES)
	@echo OBJ_F: $(OBJ_FILES)

	@echo SRC: $(SRC)
	@echo OBJ: $(OBJ)

.PHONY: distclean
distclean:
	rm -rf $(BUILD_DIR)
