function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
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

  # Determin matricea H;
  H = zeros(dim, dim);
  for i = 1 : dim
    for j = 1 : dim
      if (adj_matrix(i, j) == 1)
        H(j, i) = 1 / num_elem(i);
      endif
    endfor
  endfor

  # Aplic functia PR_Inv pt. I - d * H pt a afla inversa;
  ident = eye(dim);
  solve = ident - d * H;
  inv_H = PR_Inv(solve);

  # Determin vectorul R in functie de matricea inv_H;
  R = inv_H * ((1 - d) / dim) * ones(dim, 1);
endfunction