/*
NAME: Can Yavuz

ABSTRACT: This program is the Yavuz algorithm. The Yavuz algorithm implements the wave
function collapse algorithm to solve the travleing salesperson problem. The program is
explained more in depth in the research paper created by the author. The main focus
point of this algorithm would be a the draw function. Inside the draw function the 
algorithm takes the created list of PVectors and divides the PVectors into groups of
three. The PVectors represent the cities in the traveling salesperson problem. The
groups are created using inspiration from the nearest neighbour algorithm. The cities in
their groups are the closest ones to each other. Afterwards, the program continues to 
assign heads and tails to the groups. In this program, the heads being the last city in
the groups and the tail being the first city in the groups. The programs then chooses a
group of city to start creating the route. It creates the route inside that group and
then moves on to see which other group of city to connect with. In order to figure that
out the program sees which head to tail combination is the shortest. After it figures it
out it connects the current group with the next group and repeats the process. 

The calcDistance function takes those two parameters and loops through the PVectors list.
For the given index and the indices in the PVectors list it calculates the distance
between the points. The function then finds the shortest distance between the given
index and all the other indices that were looped through. The function then returns the
city index that had the shortest distance to the given city.

Overall, this program is an innovative and abstract approach to the traveling salesperson
problem.
*/

ArrayList<PVector> cities; // Creates the list to store the cities as PVectors
boolean[] visited; // Creates a boolean array to check which cities are visited
int totalCities = 9; // Decides the total amount of cities

void setup() {
  size(400, 300); // Creates canvas
  cities = new ArrayList<PVector>(); // Initializes the cities list
  visited = new boolean[totalCities]; // Initializes the boolean array
  for (int i = 0; i < totalCities; i++) { // Loops to add cities to both lists
    //PVector v = new PVector(random(width), random(height)); // Creates random cities
    //cities.add(v); // Uncomment these two lines for random composition of cities 
    visited[i] = false; 
  }
  cities.add(new PVector(50, 50)); // Test composition of cities
  cities.add(new PVector(100, 50));
  cities.add(new PVector(100, 100));
  cities.add(new PVector(150, 100));
  cities.add(new PVector(150, 150));
  cities.add(new PVector(200, 150));
  cities.add(new PVector(200, 200));
  cities.add(new PVector(250, 200));
  cities.add(new PVector(250, 250));
}

void draw() {
  background(0);
  fill(255);
  for (int i = 0; i < totalCities; i++) {
    ellipse(cities.get(i).x, cities.get(i).y, 8, 8); // Draws cities as ellipses
  }
  
  ArrayList<ArrayList<PVector>> alllist = new ArrayList<ArrayList<PVector>>();
  // Creates an array list with arraylists of PVectors to store the groups of 
  // three cities together
  
  stroke(255);
  strokeWeight(1);
  noFill();
  beginShape(); // Creates a shape to draw edges connecting cities
  int id = 0; // Sets the id of the city to find the closest city to
  int totaldistance = 0; // Variable for total distance of path used for testing
  visited[0] = true; // Sets the first city in the boolean array to true
  for (int j = 0; j < totalCities / 3; j++){
    ArrayList<PVector> passlist = new ArrayList<PVector>();
    // Creates arraylist to host groups of cities
    for (int i = 0; i < totalCities / 3; i++) {
      int loc = calcDistance(cities, id);
      // Sets the location of the next city to run the distance function on
      passlist.add(cities.get(id)); // Adds the current city to a group
      visited[loc] = true; 
      // Sets the next city to true in the boolean array
      id = loc; // Makes the next city the current city so that function can run again
    }
  alllist.add(passlist); // Adds the group of cities to the main list for storage
  }
  
  
  ArrayList<PVector> passer = alllist.get(0);
  int counter = 0; // Creates a counter to see which group of city the program is on
  for (int i = 0; i < alllist.size(); i++){
    // Takes out one of the groups to draw the vertices and calculate distance
    if (counter == 0){
      for (int k = 0; k < passer.size() - 1; k++){ 
        totaldistance += dist(passer.get(k).x, passer.get(k).y, passer.get(k+1).x, passer.get(k+1).y);
        // Calculates distance of the first group
      }
      for (int j = 0; j < passer.size(); j++){ 
        vertex(passer.get(j).x, passer.get(j).y);
        // Creates the vertices of the first group
      }
      ArrayList<PVector> holder = alllist.get(1);
      // Stores one of the other two groups in the main list
      ArrayList<PVector> holder1 = alllist.get(2);
      // Stores one of the other two groups in the main list
      if (dist(passer.get(2).x, passer.get(2).y, holder.get(2).x, holder.get(2).y) < dist(passer.get(2).x, passer.get(2).y, holder1.get(2).x, holder1.get(2).y)){
        // Figure out which header to tail combination is the shortest
        vertex(holder.get(2).x, holder.get(2).y);
        // Assigns the vertex accordingly
        totaldistance += dist(passer.get(2).x, passer.get(2).y, holder.get(2).x, holder.get(2).y);
        passer = holder;
      }else{
        // Figure out which header to tail combination is the shortest
        vertex(holder1.get(2).x, holder1.get(2).y);
        // Assigns vertex accordingly
        totaldistance += dist(passer.get(2).x, passer.get(2).y, holder1.get(2).x, holder1.get(2).y);
        passer = holder1;
      }
      counter += 1;
    } 
    if (counter == 1){
      // Moves onto second group of cities
      for (int k = 2; k > 0; k--){ 
        totaldistance += dist(passer.get(k).x, passer.get(k).y, passer.get(k - 1).x, passer.get(k - 1).y);
        // Calculates distance
      }
      for (int j = 0; j < 3; j++){ 
        vertex(passer.get(j).x, passer.get(j).y);
        // Assigns vertices to the cities in the group
      }
      ArrayList<PVector> holder = alllist.get(2);
      vertex(holder.get(0).x, holder.get(0).y);
      // Connects its header to the tail of the last group remaining
      totaldistance += dist(passer.get(2).x, passer.get(2).y, holder.get(2).x, holder.get(2).y);
      counter += 1;
      passer = holder;
    } 
    if (counter == 2){
      // Moves onto the last group
      for (int k = 2; k > 0; k--){ 
        totaldistance += dist(passer.get(k).x, passer.get(k).y, passer.get(k-1).x, passer.get(k-1).y);
      }
      for (int j = 0; j < 3; j++){ 
        vertex(passer.get(j).x, passer.get(j).y);
        // Draws the vertices for the last group in the array list
      }
    } 
    
  }
  
  println("totaldistance:", totaldistance);
  endShape();
  noLoop();
}

int calcDistance(ArrayList<PVector> points, int c) {
  float dist = 0; // Creates a variable to store the distance between two points
  int holder = 0; // Creates variable to store index of next city
  for (int i = 0; i < points.size(); i++) {
    if (i == c){
      continue; 
      // Ignore if the city to measure distance to is the same one in the parameter
    }
    if(visited[i]) {
      continue; 
      // Ignore if the city has already been visited (Marked true)
    }  
    float d = dist(points.get(c).x, points.get(c).y, points.get(i).x, points.get(i).y);
    // Calculates the distance between the city given in the parameter and the city that
    // is next in the city list
    if (dist == 0){ // Condition if it is the first loop of the function
     dist = d; // Sets the distance from the resutl of the first loop
     holder = i; // Sets the index from the resutl of the first loop
    }
    if(d < dist){ // If there is a distance that is shorter than the stored one then 
    // update the dist variable and the holder variable
       dist = d;
       holder = i;
      }
    }
  return holder; // Returns index of the next city to draw a line to
}
