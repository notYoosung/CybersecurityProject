## Copyright (C) 2024 ble1
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} Encode (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: ble1 <ble1@PE-303-01>
## Created: 2024-10-28

function[EncodedCell] = Encode(Cell, Rotation)
EncodedCell = {};

%Cell = input('Cell to encode: ', 's');
%Rotation = input('Amount of rotation: ');
for i = 1:size(Cell, 2)
    disp(size(Cell, 2))

  String = Cell{1, i};
  if length(String) == 0
    continue
  end
  EncodedCell{1, i} = '';
  for j = 1:length(String)
    ASCIICode = double(String(j));

    if ASCIICode >= 65 && ASCIICode <= 90 % Uppercase
        ASCIIRotated = 65 + mod(ASCIICode + Rotation - 65, 26);
    elseif ASCIICode >= 97 && ASCIICode <= 122 % Lowercase
        ASCIIRotated = 97 + mod(ASCIICode + Rotation - 97, 26);
    elseif ASCIICode >= 48 && ASCIICode <= 57 % Numbers
        ASCIIRotated = 48 + mod(ASCIICode + Rotation - 48, 26);
    else
        ASCIIRotated = ASCIICode;
    endif

    EncodedCell{1, i}(j) = char(ASCIIRotated);

  end
end

endfunction
