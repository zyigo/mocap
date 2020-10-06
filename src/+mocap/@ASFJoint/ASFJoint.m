classdef ASFJoint
    %JOINT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Name
        Parent
        ID
        Offset
        Orientation
        Axis
        AxisOrder
        Channels
        BodyMass
        ConfMass
        Order
        RotInd
        PosInd
        Children
        Limits
    end
    
    properties (Dependent)
        CInv
        C
        ChannelOrder
    end
    
    properties (SetAccess = immutable)
        Skeleton
    end
    
    methods
        function obj = ASFJoint(skeleton)
            %JOINT Construct an instance of this class
            %   Detailed explanation goes here
            str = "'skeleton' must be of the class 'mocap.ASFSkeleton'";
            assert(isa(skeleton,'mocap.ASFSkeleton'),str);
            obj.Skeleton = skeleton;
        end
        
        function obj = set.AxisOrder(obj,axisOrder)
            A1 = axisOrder == "xyz";
            A2 = axisOrder == "xzy";
            A3 = axisOrder == "yzx";
            A4 = axisOrder == "yxz";
            A5 = axisOrder == "zxy";
            A6 = axisOrder == "zyx";
            A = A1 || A2 || A3 || A4 || A5 || A6;
            assert(A,"Cannot set joint axis order. Incorrectly defined.");
            obj.AxisOrder = axisOrder;
        end
        
        function C = get.C(obj)
            a = obj.Skeleton.Angle;
            A = ~isempty(obj.Axis);
            B = ~isempty(obj.Orientation);
            assert(xor(A,B),"ERROR TODO");
            if A
                C = RotationMatrix(obj.Axis, obj.AxisOrder, a);
            else
                C = RotationMatrix(obj.Orientation, obj.AxisOrder, a);
            end
            
        end
        
        function Cinv = get.CInv(obj)
            Cinv = inv(obj.C);
        end
        
        function ChannelOrder = get.ChannelOrder(obj)
            ChannelOrder = zeros(1,length(obj.Channels));
            for c = 1:length(obj.Channels)
                switch obj.Channels(c)
                    case "xRot"
                        ChannelOrder(c) = 1;
                    case "yRot"
                        ChannelOrder(c) = 2;
                    case "zRot"
                        ChannelOrder(c) = 3;
                end
            end
        end
    end
end

