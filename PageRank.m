function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out
  R1 = Iterative(nume, d, eps);
  R2 = Algebraic(nume, d, eps);
  # Citesc si salvez val1 si val2 din fisier intrare;
  read_matrix = dlmread(nume, ' ', 1, 0);
  [m n] = size(read_matrix);
  val1 = read_matrix(m, 1);
  val2 = read_matrix(m - 1, 1);
  [m n] = size(R1);
  
  # Modific numele fisierului de iesire, concatenez string-ul primit
  # ca input la extensia .out;
  outputname = strcat(nume, '.out');
  output = fopen(outputname, "w");
  
  # Printez numarul de page-uri (m)
  fprintf(output, "%d", m);
  fprintf(output, "\n");
  fprintf(output, "\n");

  # Printez toate elementele vectorului R1, cel determninat cu Iterative;
  for i = 1 : m
    fprintf(output, '%f ', R1(i));
    fprintf(output, "\n");
  endfor
  fprintf(output, "\n");

  # Printez si elementele vectorului R2, determinat cu Algebraic.
  for i = 1 : m
    fprintf(output, '%f ', R2(i));
    fprintf(output, "\n"); 
  endfor
  fprintf(output, "\n");

  # Sortez descendent vectorul R2, m-am folosit de functia sort, cu parametrul
  # descend;
  PR1 = sort(R2, 'descend');

  # Parcurg ambii vectori sa salvez in vectorul index pozitiile nodurilor
  # anterioare;
  for i = 1 : m
    for j = 1 : m
      if (R2(j) == PR1(i))
        index(i) = j;
      endif
    endfor
  endfor
  
  # Printez in formatul dorit, indicele, apoi fostii indici ai vectorului R2,
  # din vectorul index, apoi aplic functia Apartenenta;
  for i = 1 : m
    fprintf(output, "%d ", i);
    fprintf(output, "%d ", index(i));
    fprintf(output, "%f ", Apartenenta(PR1(i), val2, val1));
    fprintf(output, "\n");
  endfor
  fclose(output);
endfunction