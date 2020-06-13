function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si care calculeaza valoarea functiei membru in punctul x.
	% Stim ca 0 <= x <= 1
  
  # Ca functia sa fie continua: ;
  # y(val1) in (0) = y(val1) in ax + b;
  #a * val1 + b = 0;
  #a * val2 + b = 1;
  a = double(1 / double((val2 - val1)));
  b = double(-val1 / double((val2 - val1)));
  
  # Analizez functia pe ramuri: - member function, y = u(x)
  
  # Pe intervalul [0, val1);
  if x < val1 && x >= 0
    y = 0;
  endif
  
  # Pe intervalul [val1, val2);
  if x >= val1 && x <= val2
    y = a * x + b;
  endif
  
  # Pe intervalul (val2, 1);
  if x <= 1 && x > val2
    y = 1;
  endif
endfunction