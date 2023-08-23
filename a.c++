#include "mpi"

Reducao(List_of_elements A, int T)
{
    Board B; // instancia um tabuleiro (matriz)
    
    List_of_pieces L; // Lista de tetrominos

    num_buckets = A.size(); // numero de buckets a serem gerados
    			    // equivalente ao numero de conjuntos do 
    			    // 3PAT
    			    
    num_notches = T + 3; // numero de notches
    
    H = 5 * T + 18; // altura do tabuleiro

    B.create_board(num_buckets, num_notches, H); // cria o tabuleiro com as dimensoes
                                                 // especificadas, algoritmo complexo 
                                                 // apresentado em Hoogeboom et al. 2003
                                                 // que possui complexidade polinomial
                                                

    for(i=0; i < A.size(); i++) // itera sobre todos os elementos de A
    {
        L.add_piece('L'); // adiciona "start"
        for(j = 0; j < A[i]; j++) // para o valor de A adicionamos as pecas
                                  // da parte 2 do algoritmo
        {
            L.add_piece('O');
            L.add_piece('J');
            L.add_piece('O');
        }
        L.add_piece('O');   // adiciona "end"
        L.add_piece('I'); 
    }

    for(i=0; i < num_buckets; i++) // preenche o final com L
    {
        L.add_piece('L');
    }

    L.add_piece('T'); // realiza o unlock

    for(i=0; i < H - 2; i++) // preenche o fill area
    {
        L.add_piece('I');
    }

}










Board B; // tabuleiro em que sera jogado o jogo

List_of_pieces L; // Lista de tetrominos que serao jogados

Trajetorias T; // Lista de trajetorias que serao jogadas


for (i=0; i < L.size(); i++) // itera sobre todas as peças
{
    play_piece(B, L[i], T[i]); // joga o tetromino no tabuleiro
                               // esta funcao tem no maximo 4 · |B| + 1 estados
                               // ou seja se testarmos para cada caso ela possui complexidade
                               // O(B.nrows * B.ncols)     
}

cleared = true;

for (j=0; j<B.cols();j++) //itera sobre as linhas de B
{    
    if(B.occupied(0, j)) // testa se a maior altura ocupada eh maior que h 
    {    
        cleared = false; // atualiza a altura maxima
    }
}

return cleared;





















