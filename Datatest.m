function Datatest(arg)

pkg load io;


function name = ColLetter(n)
    name = '';

    while (n > 0)
        name = [char(double('A') + mod(n - 1, 26)), name];
        n = int16(n / 26);
    endwhile

endfunction


l = ColLetter(arg)


endfunction