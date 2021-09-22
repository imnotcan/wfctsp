/*
NAME: Can Yavuz

ABSTRACT: This is my version of the implementation of the nearest neighbour algorithm
in the traveling salesperson problem. The program starts of by taking the amount of 
cities desired to create a route between. The program creates an array list of PVectors
which will represent the cities and an array of booleans which will check if a certain
city has been visitied while checking for distances. In order to represent the cities 
in the output the program creates ellipses at the position of each PVector. The program
also creates a shape to create vertices at each city so an edge can be drawn to each 
city to represent the edges. The main function of this program is the calcDistance
function. The function takes in two parameters. The first parameter would be the 
array if PVectors and the second parameter would be the index of the city in the
PVectors array that the program is trying to find the closest PVector to. 
The calcDistance function takes those two parameters and loops through the PVectors list.
For the given index and the indices in the PVectors list it calculates the distance
between the points. The function then finds the shortest distance between the given
index and all the other indices that were looped through. The function then returns the
city index that had the shortest distance to the given city. The program then continues
the same process for the remainder of the cities. The end of this process results in 
a solution for the traveling salesperson problem through the nearest neighbour algorithm.


*/



ArrayList<PVector> cities; // Creates the list to store the cities as PVectors
boolean[] visited; // Creates a boolean array to check which cities are visited
int totalCities = 9; // Decides the total amount of cities

void setup() {
  size(400, 300); // Creates canvas
  cities = new ArrayList<PVector>(); // Initializes the cities list
  visited = new boolean[totalCities]; // Initializes the boolean array
  for (int i = 0; i < totalCities; i++) { // Loops to add cities to both lists
    PVector v = new PVector(random(width), random(height)); // Creates random cities
    cities.add(v);
    visited[i] = false; 
  }
}


void draw() {
  background(0);
  fill(255);
  for (int i = 0; i < totalCities; i++) {
    ellipse(cities.get(i).x, cities.get(i).y, 8, 8); //Draws cities as ellipses
  }
  
  stroke(255);
  strokeWeight(1);
  noFill();
  beginShape(); // Creates a shape to draw edges connecting cities
  int totaldistance = 0; // Variable for total distance of path used for testing
  int id = 0; // Sets the id of the city to find the closest city to
  visited[0] = true; // Sets the first city in the boolean array to true
  for (int i = 0; i < totalCities; i++) {
    int loc = calcDistance(cities, id); 
    // Sets the location of the next city to run the distance function on
    totaldistance += dist(cities.get(id).x, cities.get(id).y, cities.get(loc).x, cities.get(loc).y);
    // Adds the distance between the two cities to the total distance
    vertex(cities.get(id).x, cities.get(id).y);
    // Represents the city as a vertex for the created shape so an edge can be drawn
    visited[loc] = true; // Sets the next city to true in the boolean array
    id = loc; // Makes the next city the current city so that function can run again
  }
  endShape(); // Ends shape so all edges can be drawn
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
