function Datatest(arg)

pkg load io;


function name = ColLetter(n)
    name = '';

    while (n > 0)
        n = n - 1;
        name = [char(double('A') + mod(n, 26)), name];
        n = int16(n / 26/2);
    endwhile

endfunction


l = ColLetter(arg)


endfunction