# Here put where you have installed devkitpro
DEVKITPRO = /opt/devkitpro
DEVKITARM = $(DEVKITPRO)/devkitarm

TOOLS = $(DEVKITARM)/bin
DC=ldc2 # The compiler arguments only work with ldc2
CC = $(TOOLS)/arm-none-eabi-gcc
OBJCOPY = $(TOOLS)/arm-none-eabi-objcopy
GBAFIX = $(DEVKITPRO)/tools/bin/gbafix

TARGET = $(BIN)/main

SRC = source
INCLUDE = include
OBJ = obj
BIN = bin

D_SOURCES := $(wildcard $(SRC)/*.d)
D_OBJECTS := $(patsubst $(SRC)/%.d, $(OBJ)/%.o, $(D_SOURCES))

C_SOURCES := $(wildcard $(SRC)/*.c)
C_OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(C_SOURCES))

all: $(D_OBJECTS) $(C_OBJECTS)
	$(CC) $(D_OBJECTS) $(C_OBJECTS) -O3 -flto -mthumb-interwork -mthumb -specs=gba.specs -o $(TARGET).elf
	$(OBJCOPY) -v -O binary $(TARGET).elf $(TARGET).gba
	$(GBAFIX) $(TARGET).gba

$(OBJ)/%.o: $(SRC)/%.d
	$(DC) -betterC -O5 -mtriple=arm-none-eabi -c -arm-interworking -od=obj $<

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) -I $(INCLUDE) -O3 -c $< -mthumb-interwork -mthumb -O2 -o $@
