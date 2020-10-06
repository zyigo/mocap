function matrix = RotationMatrix(angles, order, type)
% ROTATIONMATRIX Calculate the Euler Rotation Matrix
% angles: The angles to rotate by. Array order should be [x,y,z].
% order: The order of rotations made. Default is xyz.
% type: Degrees or radians. ('deg' or 'rad'). Default is 'radians'.

%% Test Input
assert(nargin > 0, 'At least 1 argument (angles) is required for this function.')
assert(nargin < 4, 'This function takes a maximum of 3 arguments. See help.')
assert(length(angles) == 3, 'Angle array must have 3 elements.')
assert(isnumeric(angles) == 1, 'Angle array must be numeric');

if nargin < 2
    order = 'xyz';
end
order = lower(order);
str = 'Order must be char array and contain in some order ''x'', ''y'' and ''z''.';
assert(sort(order) == "xyz",str);
order = char(order);

if nargin < 3
    type = 'rad';
end
assert(type == "deg" || type == "rad", 'Type must be ''deg'' or ''rad''');

%% Prepare Angle Array
if type == "deg"
    angles = deg2rad(angles);
end

c = cos(angles);
s = sin(angles);

%% Calculate Matrix
matrix = eye(3);
for i = 1:3
    switch order(i)
        case 'x'
            matrix = [1, 0, 0; 0, c(1), s(1); 0, -s(1), c(1)] * matrix;
        case 'y'
            matrix = [c(2), 0, -s(2); 0, 1, 0; s(2), 0, c(2)] * matrix;
        case 'z'
            matrix = [c(3), s(3), 0; -s(3), c(3), 0; 0, 0, 1] * matrix;
    end
end