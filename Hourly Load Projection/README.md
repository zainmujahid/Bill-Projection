# Hourly Bill Projection

## Steps to successfully evaluate/run the code:

-  Add downloaded folder in the path directory of MATLAB
-  load_projection.m is the main script.
-  Run load_projection.m and simply follow the lead shown in Command Window.
-  The script will repeatedly ask you to press Enter in order to proceed.
-  Every output can be seen in command window, we tried our best to make it as simple to undertand as we could.
-  Out of line 40,41 and 42 in load_projection.m ONLY ONE SHOULD BE UNCOMMENTED AT A TIME.
	- Line 40 - If we take initial Theta vector containing all zeros
	- Line 41 - If we take initial Theta vector containing values from 0 to 1
	- Line 42 - If we take initial Theta vector containing values from 0 to 15
    - With each condition, gradient descent will converge to different local minima you can witness it by seeing predicted load.
    - Personally, I prefer initializing Theta with all zeros. (Line 40)  
-  You can enter input feautures manually from line number 67 to 70.
-  You can witness the changings in convergence plot as you do step 5 and 6.
-  Just keep pressing Enter in command window and enjoy the script.
- Code is well commented and easy to evaluate.
- Thank You.