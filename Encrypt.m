function [Encrypted, EncryptedKey] = Encrypt(Cell)

%Cell = input('Cell to encode: ', 's');

ASCIIUpper = [65:90];
ASCIILower = [97:122];
ASCIINumber = [48:57];
CharPool = [ASCIIUpper ASCIILower ASCIINumber];

EncryptedText = '';

Key = [];
CurrIndex = 1;
for i = 1:length(Cell)
  SepLen = randi(10);
  for Sep = 1:SepLen
      EncryptedText(CurrIndex) = CharPool(randi(length(CharPool)));
      CurrIndex = CurrIndex + 1;
  endfor



  EncryptedText(CurrIndex) = Cell(i);
  Key(length(Key) + 1) = CurrIndex;
  CurrIndex = CurrIndex + 1;

endfor

SepLen = randi(10);
for Sep = 1:SepLen
    EncryptedText(CurrIndex) = CharPool(randi(length(CharPool)));
    CurrIndex = CurrIndex + 1;
endfor


Encrypted = EncryptedText;
EncryptedKey = mat2str(Key);

endfunction
