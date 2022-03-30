

///// Variables globales concernant la balle :
int ball_x , ball_y; // coordonnées
int ball_size; // diamètre
int ball_speed; // vitesse = distance en pixels parcourue en une frame
int ball_direction_x , ball_direction_y; // Alterneront entre 1 et -1
int score;
int score2;
int scoreWin;
boolean gameStatus;

// Pas encore utilisé :
boolean ball_is_moving; // servira à attendre une touche de clavier pour (re)lancer le mouvement de la balle


///// Variables globales concernant le premier pad :
int filet_x;
int filet_y;
int filet_width;
int filet_height;

int pad_x , pad_y; // coordonnées
int pad_width , pad_height; // dimensions
int pad_speed; // vitesse = distance en pixels parcourue en une frame
boolean pad_up , pad_down; // reflèteront l'état des touches haut / bas
boolean pad2_up , pad2_down; // reflèteront l'état des touches haut / bas

int pad2_x , pad2_y; // coordonnées
int pad2_width , pad2_height; // dimensions
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

boolean previous_frame_intersect_x , previous_frame_intersect_y;
boolean previous_frame_intersect2_x , previous_frame_intersect2_y;

String messageWin = "Bravo le joueur 1 a gagné";
String messageWin2 = "Bravo le joueur 2 a gagné";

 color pad_left_color;
 color pad_right_color;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


void setup() { // fonction exécutée automatiquement une fois, en début de programme

 pad_left_color = color(255, 0, 0);
 pad_right_color = color(255, 0, 0);

  gameStatus = true;
  scoreWin = 3;
  frameRate(30); // Forcer la fréquence à 30 images / secondes
  size(1280,720); // Redimensionner la fenêtre de rendu
  
  ///// Initialisation de la balle :
  
  ball_x = width / 2; // centrée en largeur
  ball_y = height / 2; // centrée en hauteur
  
  ball_size = 40;
  ball_speed = 15;
  
  ball_direction_x = 1; // -1 : gauche | 1 : droite
  ball_direction_y = 1; // -1 : haut | 1 : droite

if (random(100) >= 50) {
  ball_direction_x *= -1;
} 

if (random(100) >= 50) {
  ball_direction_y *= -1;
} 

  ball_is_moving = false; 
  
  filet_x = width/2;
  filet_y = height/2;
  filet_width = 10;
  filet_height = height;
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  
   previous_frame_intersect_x = false;
  previous_frame_intersect_y = false;
  
     previous_frame_intersect2_x = false;
  previous_frame_intersect2_y = false;
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  
  ///// Initialisation du pad de gauche :
    
  pad_x = 20;
  pad_y = height / 2; // centré en hauteur
  
  pad_width = 10;
  pad_height = 150;
  
    ///// Initialisation du pad de droite :
  
  pad2_x = width - 20;
  pad2_y = height / 2; // centré en hauteur
  
  pad2_width = 10;
  pad2_height = 150;
  
  pad_speed = 20;

  pad_up = false; // deviendra true lorsque touche haut pressée | false lorsque relachée
  pad_down = false; // deviendra true lorsque touche bas pressée | false lorsque relachée
  
  pad2_up = false; // deviendra true lorsque touche haut pressée | false lorsque relachée
  pad2_down = false; // deviendra true lorsque touche bas pressée | false lorsque relachée
  
} // Fin setup()


///////////////////////////////////////////////////////////////////////////////////////////////////////////////


void draw() { 
  

  
  if (gameStatus == true){
  
  // fonction exécutée automatiquement en boucle
  
  ///// 1) Mise à jour des coordonnées des différents éléments
  
  // Collision balle / bords haut et bas fenêtre
  if(ball_is_moving == false){
  ball_speed = 0;
  } else if (ball_is_moving == true){
  ball_speed = 15;
  }
  
  
  if (ball_y - ball_size / 2 <= 0 || ball_y + ball_size / 2 >= height) {
    ball_direction_y *= -1;
  }
  
   // Collision balle / bord droit fenêtre (temporaire)
  if (ball_x + ball_size / 2 >= width) {
    ball_direction_x *= -1; // On peut faire alterner la valeur entre 1 et -1, en la multipliant par -1
  }
  


   // Dépassement balle / bord gauche fenêtre (il faudra adapter ce fonctionnement au bord droit également une fois le pad 2 fonctionnel)
  if (ball_x + ball_size / 2 <= 0) {
  
    // La balle est replacée au centre
    ball_x = width / 2;
    ball_y = height / 2;
    ball_is_moving = false;
    score2 ++;
    if (random(100) >= 50) {
  ball_direction_x *= -1;
} 

if (random(100) >= 50) {
  ball_direction_y *= -1;
} 
  
  }
  
    if (ball_x + ball_size / 2 >= width) {
  
    // La balle est replacée au centre
    ball_x = width / 2;
    ball_y = height / 2;
    ball_is_moving = false;
    score ++;
    if (random(100) >= 50) {
  ball_direction_x *= -1;
} 

if (random(100) >= 50) {
  ball_direction_y *= -1;
} 
  
  }
  

  
  
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  int ball_left_edge_x = ball_x - ball_size / 2;
 int ball_right_edge_x = ball_x + ball_size / 2;
 int ball_top_edge_y = ball_y - ball_size / 2;
 int ball_bottom_edge_y = ball_y + ball_size / 2;
 
 int pad_left_edge_x = pad_x - pad_width / 2;
 int pad_right_edge_x = pad_x + pad_width / 2;
 int pad_top_edge_y = pad_y - pad_height / 2;
 int pad_bottom_edge_y = pad_y + pad_height / 2;
 
  int pad2_left_edge_x = pad2_x - pad2_width / 2;
 int pad2_right_edge_x = pad2_x + pad2_width / 2;
 int pad2_top_edge_y = pad2_y - pad2_height / 2;
 int pad2_bottom_edge_y = pad2_y + pad2_height / 2;
 
 boolean pad_left_edge_intersect = ball_right_edge_x >= pad_left_edge_x;
 boolean pad_right_edge_intersect = ball_left_edge_x <= pad_right_edge_x;
 boolean pad_top_edge_intersect = ball_bottom_edge_y >= pad_top_edge_y;
 boolean pad_bottom_edge_intersect = ball_top_edge_y <= pad_bottom_edge_y;
 
  boolean pad2_left_edge_intersect = ball_right_edge_x >= pad2_left_edge_x;
 boolean pad2_right_edge_intersect = ball_left_edge_x <= pad2_right_edge_x;
 boolean pad2_top_edge_intersect = ball_bottom_edge_y >= pad2_top_edge_y;
 boolean pad2_bottom_edge_intersect = ball_top_edge_y <= pad2_bottom_edge_y;
 
 boolean intersect_x = pad_left_edge_intersect && pad_right_edge_intersect;
 boolean intersect_y = pad_top_edge_intersect && pad_bottom_edge_intersect;
 
 boolean intersect2_x = pad2_left_edge_intersect && pad2_right_edge_intersect;
 boolean intersect2_y = pad2_top_edge_intersect && pad2_bottom_edge_intersect;
 
if (intersect_x && intersect_y) {
  pad_left_color = color(255, 255, 255);
}
  else { pad_left_color = color(255, 0, 0); 
}

if (intersect2_x && intersect2_y) {
  pad_right_color = color(255, 255, 255);
}
  else { pad_right_color = color(255, 0, 0);
}

 
  if (previous_frame_intersect_x && !previous_frame_intersect_y && intersect_y) {
   ball_direction_y *= -1;
 }
 
 // Pour que le rebond se fasse sur l'axe horizontal :
 // - Une intersection sur l'axe vertical devait déjà être vraie sur la précédente frame
 // - Sur l'axe horizontal il faut au contraire qu'elle ne devienne vraie que sur la frame actuelle
 if (previous_frame_intersect_y && !previous_frame_intersect_x && intersect_x) {
   ball_direction_x *= -1;
 }
  
  // Ne pas oublier de mettre à jour nos "sauvegardes" de scénarios, qui seront testées à nouveau pour la frame suivante
  previous_frame_intersect_x = intersect_x;
  previous_frame_intersect_y = intersect_y;
 
 
 
   if (previous_frame_intersect2_x && !previous_frame_intersect2_y && intersect2_y) {
   ball_direction_y *= -1;
 }
 
 // Pour que le rebond se fasse sur l'axe horizontal :
 // - Une intersection sur l'axe vertical devait déjà être vraie sur la précédente frame
 // - Sur l'axe horizontal il faut au contraire qu'elle ne devienne vraie que sur la frame actuelle
 if (previous_frame_intersect2_y && !previous_frame_intersect2_x && intersect2_x) {
   ball_direction_x *= -1;
 }
  
  // Ne pas oublier de mettre à jour nos "sauvegardes" de scénarios, qui seront testées à nouveau pour la frame suivante
  previous_frame_intersect2_x = intersect2_x;
  previous_frame_intersect2_y = intersect2_y;
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
   
  // Calcul de la nouvelle position de la balle
  ball_x += ball_speed * ball_direction_x;
  ball_y += ball_speed * ball_direction_y;
  
  // Calcul de la nouvelle position du pad 1
  if (pad_up) { // ou : if (pad_up == true) - c'est le cas lorsque la touche haut est pressée
  
    // si pad ne touche pas bord haut fenêtre, déplacement vers le haut
    if (pad_y - pad_height / 2 > 0) { 
      pad_y -= pad_speed;
    }
  
  } else if (pad_down) { // ou : if (pad_down == true) - c'est le cas lorsque la touche bas est pressée
  
    // si pad ne touche pas bord bas fenêtre, déplacement vers le bas
    if (pad_y + pad_height / 2 < height) {
      pad_y += pad_speed;
    }
  
  }
  
  if (pad2_up) { // ou : if (pad_up == true) - c'est le cas lorsque la touche haut est pressée
  
    // si pad ne touche pas bord haut fenêtre, déplacement vers le haut
    if (pad2_y - pad2_height / 2 > 0) { 
      pad2_y -= pad_speed;
    }
  
  } else if (pad2_down) { // ou : if (pad_down == true) - c'est le cas lorsque la touche bas est pressée
  
    // si pad ne touche pas bord bas fenêtre, déplacement vers le bas
    if (pad2_y + pad2_height / 2 < height) {
      pad2_y += pad_speed;
    }
  
  }

  ///// 2) Dessiner les éléments dans la fenêtre

  background(0,0,0); // remplit la fenêtre de noir (et efface l'ancien état des éléments dessinés)
  fill(255,0,0);
  rect(filet_x , filet_y , filet_width , filet_height);
  noStroke(); // désactive le contour de ce qui sera dessiné par la suite
  fill(255,255,255);
  ellipse(ball_x , ball_y , ball_size, ball_size); // dessine la balle selon ses nouvelles cooronnées
  rectMode(CENTER); // établit que pour les rectangles dessinés par la suite, les coordonnées x/y correspondront au centre, et non au coin supérieur gauche
  fill(pad_left_color);
  rect(pad_x , pad_y , pad_width , pad_height); // dessine le pad 1 selon ses nouvelles coordonnées
  fill(pad_right_color);
  rect(pad2_x , pad2_y , pad2_width , pad2_height);
  stroke(255,255,255);
  fill(255,0,0);

String message = "Score:" + score;
String message2 = "Score:" + score2;


textSize(40);
textAlign(CENTER,CENTER); // Pour un comportement proche de rectMode(CENTER) pour les rectangles (vis-à vis des coordonnées x et y)

text(message, width/4 , height/10);
text(message2, width*3/4 , height/10);


if (score == scoreWin){ 
  gameStatus = false;
  }
  
else if (score2 == scoreWin){
  gameStatus = false;
  }
  


} 
else {
  if (score == scoreWin){ 
 
  background(0,0,0);
    text(messageWin, width/4 , height/2);
  }
  
else if (score2 == scoreWin){
  background(0,0,0);
 text(messageWin2, width*3/4 , height/2);
  }
}
} 



// Fin draw()


///////////////////////////////////////////////////////////////////////////////////////////////////////////////


void keyPressed() { 
  
  if (score == scoreWin){ 
    score = 0;
    score2 = 0;
    gameStatus = true;
  }
  
else if (score2 == scoreWin){
    score = 0;
    score2 = 0;
    gameStatus = true;
  }
  
  
  // fonction exécutée en boucle (indépendamment de draw() et moins souvent) tant qu'une touche de clavier est pressée
  
  // dans cette fonction on a accès à une variable keyCode - un code correspondant à la touche pressée
  // via println(keyCode) ici, on observe dans la console que :
  // Flèche haut : 38
  // Flèche bas : 40
  
  if (keyCode == 90) {
  
    pad_up = true;
    pad_down = false;
    ball_is_moving = true;
  
  } else if (keyCode == 83) {
  
    pad_down = true;
    pad_up = false;
    ball_is_moving = true;
    
  }
  


if (keyCode == 38) {
  
    pad2_up = true;
    pad2_down = false;
    ball_is_moving = true;
  
  } else if (keyCode == 40) {
  
    pad2_down = true;
    pad2_up = false;
    ball_is_moving = true;
    
  }
  
}



void keyReleased() { // fonction exécutée lorsqu'une touche de clavier est relachée

  // keyCode est accessible ici comme dans keyPressed(), et concerne la touche relachée

  if (keyCode == 90) {
  
     pad_up = false;
   
  
  } else if (keyCode == 83) {
  
     pad_down = false;
     
  
  }



  if (keyCode == 38) {
  
     pad2_up = false;
   
  
  } else if (keyCode == 40) {
  
     pad2_down = false;
     
  
  }

}
