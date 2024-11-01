function [EncryptedCell, EncryptedCellKeys] = Encrypt(Cell)
EncryptedCell = {};
EncryptedCellKeys = {};

ASCIIUpper = [65:90];
ASCIILower = [97:122];
ASCIINumber = [48:57];
CharPool = [ASCIIUpper ASCIILower ASCIINumber];

for iCell = 1:size(Cell, 2)
  EncryptedCell{1, iCell} = {};
  EncryptedCellKeys{1, iCell} = {};

  EncryptedText = '';

  Key = [];
  CurrIndex = 1;
  for i = 1:size(Cell{1, iCell}, 2)
    SepLen = randi(10);
    for Sep = 1:SepLen
        EncryptedText(CurrIndex) = CharPool(randi(length(CharPool)));
        CurrIndex = CurrIndex + 1;
    endfor

    EncryptedText(CurrIndex) = Cell{1, iCell}(i);
    Key(1, size(Key, 2) + 1) = CurrIndex;
    CurrIndex = CurrIndex + 1;

  endfor

  SepLen = randi(10);
  for Sep = 1:SepLen
      EncryptedText(CurrIndex) = CharPool(randi(length(CharPool)));
      CurrIndex = CurrIndex + 1;
  endfor


  EncryptedCell{1, iCell} = EncryptedText;
  EncryptedCellKeys{1, iCell} = Key;
endfor

endfunction
