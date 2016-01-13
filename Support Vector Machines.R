x1 = c(3,2,4,1,2,4,4);
x2 = c(4,2,4,4,1,3,1);
colors = c(rep("red", 4), rep("blue", 3));
plot(x1, x2, col = colors, xlim = c(0,5), ylim = c(0,5));

#The best seperating line is between points (2,2) (4,4) which are red & (2,1) (4,3) which are blue.
#We take the average of of the two corresponding points in red and blue, to get points on Hyperplane.
#Average = (2,1.5) (4,3.5) which determine the points on the Hyperplane
#Taking these points, we form the equation of the line passing through these points. Here,
#slope = (3.5-1.5/4-2) = (2/2) = 1. Thus, the equation of line => x2-1.5 = 1(x1-2).
#Line: x2-x1 = -0.5. This will be a place in 2-D.
abline(-0.5, 1, col="green");

#Classify to red if x2 - x1 + 0.5 > 0, otherwise classify as blue.

#Intercepts of the line passing through the used to determine the Hyperplane are 0 & -1.
abline(0, 1, lty = 3);
abline(-1, 1, lty = 3);

#The support vectors here are (2,2) (4,4), (2,1) & (4,3)
arrows(2,2,2,1.5);
arrows(4,4,4,3.5);
arrows(2,1,2,1.5);
arrows(4,3,4,3.5);

#Since the hyperplane directly depends on the support vectors and not any other observation, thus
#if we move the #7 observation (4,1) slightly, it's movement will be outside the margin and hence will
#not affect the maximal margin Hyperplane.

#Any Hyperplane with smaller margin with same slope, separating the two classes is not an
#optimal Hyperplane. Hence plane : x2 - x1 + 0.2 is not an optimal Hyperplane.
abline(-0.2, 1);

#If we add a new point (3,1) -> red, then the two classes are no longer seperable by a Hyperplane.
points(c(3), c(1), col = "purple");
