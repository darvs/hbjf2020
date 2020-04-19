ACME=acme
C1541=c1541

OBJ_DIR=obj
IMG=$(OBJ_DIR)/hbj2020.d64
MKDIR_P=mkdir -p

ASM=hbjf2020.a

PRGS=$(patsubst %.a, $(OBJ_DIR)/%.prg, $(ASM))

$(shell $(MKDIR_P) $(OBJ_DIR))

.PHONY: all delete-image build-image write-prg clean

$(OBJ_DIR)/%.prg: %.a
	$(ACME) -f cbm -o $@ $<

$(OBJ_DIR)/%.d64: $(PRGS)
	$(C1541) -format $(notdir $(patsubst %.d64,%,$@)),dd d64 $@ 

all: delete-image build-image write-prg

delete-image:
	rm -f $(IMG)

build-image: $(IMG)

write-prg: $(PRGS)
	$(C1541) -attach $(IMG) -write $< $(notdir $(patsubst %.prg,%,$<))

clean:
	rm -rf $(OBJ_DIR)
