function matrix = NewRotationMatrix(angles, order, type)
% NEWROTATIONMATRIX Calculate the Euler Rotation Matrix
% angles: The angles to rotate by. Array order should be [x,y,z].
% order: The order of rotations made. Default is xyz.
% type: Degrees or radians. ('deg' or 'rad'). Default is 'radians'.

%% Test Input
%assert(nargin > 0, 'At least 1 argument (angles) is required for this function.')
%assert(nargin < 4, 'This function takes a maximum of 3 arguments. See help.')
%assert(length(angles) == 3, 'Angle array must have 3 elements.')
%assert(isnumeric(angles) == 1, 'Angle array must be numeric');

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

vecLen = length(angles);

angles = reshape(angles,[1,3,vecLen]);

c = cos(angles);
s = sin(angles);

%% Calculate Matrix
matrix = repmat(eye(3),[1,1,vecLen]);
m1s = ones(1,1,vecLen);
m0s = zeros(1,1,vecLen);

for i = 1:3
    switch order(i)
        case 'x'
            A = [   m1s,    m0s,        m0s;...
                    m0s,    c(1,1,:),   s(1,1,:);...
                    m0s,    -s(1,1,:),  c(1,1,:)];
            matrix = pagemtimes(A,matrix);
            disp(matrix);
        case 'y'
            matrix = [c(1,2,:), 0, -s(1,2,:); 0, 1, 0; s(1,2,:), 0, c(1,2,:)] .* matrix;
        case 'z'
            matrix = [c(1,3,:), s(1,3,:), 0; -s(1,3,:), c(1,3,:), 0; 0, 0, 1] .* matrix;
    end
end