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

function[Encoded] = Encode(String, Rotation)

%String = input('String to encode: ', 's');
%Rotation = input('Amount of rotation: ');

EncodedString = '';

for i = 1:length(String)

  ASCIICode = double(String(i));

  if ASCIICode >= 65 && ASCIICode <= 90 % Uppercase
      ASCIIRotated = 65 + mod(ASCIICode - 64, 90-65);
  elseif ASCIICode >= 97 && ASCIICode <= 122 % Lowercase
      ASCIIRotated = 97 + mod(ASCIICode - 96, 122-97);
  elseif ASCIICode >= 48 && ASCIICode <= 57 % Numbers
      ASCIIRotated = 48 + mod(ASCIICode - 47, 57-48);
  else
      ASCIIRotated = ASCIICode
  endif

  EncodedString(i) = char(ASCIIRotated);

endfor

%disp(['Encoded String: ' EncodedString])
Encoded = EncodedString;
endfunction
