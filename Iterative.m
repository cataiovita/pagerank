function [R] = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
 
 # Salvez dimensiunea matrice (numar pagini) din fisierul citit;
  fid = fopen(nume);
  dim = fscanf(fid,'%f', 1);
  fclose(fid);

 # Salvez matricea intermediara din fisierul citit;
  read_matrix = dlmread(nume, ' ', 1, 0);
  [m n] = size(read_matrix);

 # Salvez si sterg ultimele doua randuri din matrice;
  val1 = read_matrix(m, :);
  read_matrix(m, :) = [];
  val2 = read_matrix(m - 1, :);
  read_matrix(m - 1, :) = [];

 # A doua coloana reprezina numar elemente fiecare linie;
  num_elem = read_matrix(:, 2);

 # Introduc matricea de adiacenta;
  adj_matrix = zeros(dim, dim);

 # Iau un index sa parcurg fiecare vector din matricea initiala (k);
 # Creez matricea adiacenta;
  for i = 1 : dim
    k = 3;
    for j = 1 : dim
      if (k <= dim)
        if (j == read_matrix(i, k))
          k++;
          adj_matrix(i, j) = 1;
        endif
      else
        break;
      endif
    endfor
  endfor

  # Parcurg inca o data matricea sa verific adj_matrix(i)(i) != 1
  for i = 1 : dim
    if adj_matrix(i, i) == 1
      adj_matrix(i, i) = 0;
      num_elem(i) -= 1;
    endif
  endfor

  # Vectorul Page-Rank la momentul 0 (inainte de iteratie)
  R = 1 / dim * ones(dim, 1);
  # Creez matricea stocastica;
  H = zeros(dim, dim);
  for i = 1 : dim
    for j = 1 : dim
      if (adj_matrix(i, j) == 1)
        H(j, i) = 1 / num_elem(i);
      endif
    endfor
  endfor
  R_old = zeros(1, dim);

  # Parcurg iterativ si calculez vectorul PageRank R;
  while (norm(R - R_old) > eps)
    R_old = R;
    R = H * R_old * d + ((1 - d) / dim) * ones(dim, 1);
  endwhile
    R = R_old;
endfunction
 