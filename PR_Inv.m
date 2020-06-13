function inverse_matrix = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	
  # Am aplicat factorizarea Gram-Schmidt pentru a determina descompunerea in
  # forma QR a matricii A, apoi am determinat matricea de care am nevoie pt 
  # algoritmul de determinare a vectorului Page - Rank prin
  # utilizarea functiei inv, B = inv(R) * Q';
  [m n]=size(A);
	Q = A;
	R = zeros(m, n);
  for k = 1 : n
    R(k, k) = norm(Q(1 : m, k));
	  Q(1 : m, k) = Q(1 : m, k) / R(k, k);
	  for j = k + 1 : n
		  R(k, j) = Q(1 : m, k)' * Q(1 : m, j);
		  Q(1 : m, j) = Q(1 : m, j) - Q(1 : m, k) * R(k, j);
	  endfor
	endfor
  
  # M-am folosit de functia SST pentru a determina inversa matricii din  
  # descompunerea QR, rezolvand cele m sisteme de cuatii;
  for i = 1 : m
    inverse_matrix(:, i)=SST(R , Q'(:, i));
  endfor
endfunction