classdef Motion
    %MOTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        FrameCount
        Data
    end
    
    properties (SetAccess = immutable)
        Skeleton
    end
    
    methods
        function obj = Motion(skeleton,filepath)
            %MOTION Construct an instance of this class
            %   Detailed explanation goes here
            str = "'skeleton' must be of the class 'mocap.ASFSkeleton'";
            assert(isa(skeleton,'mocap.ASFSkeleton'),str);
            obj.Skeleton = skeleton;
            
            obj.Data = containers.Map('KeyType','double','ValueType','any');
            
            fLines = ImportAMC(filepath);
            obj = ParseAMC(obj,fLines);
        end
        
        function data = JointRotationData(obj,joint)
            x = obj.Skeleton.Joints(joint).Channels == "xRot";
            y = obj.Skeleton.Joints(joint).Channels == "yRot";
            z = obj.Skeleton.Joints(joint).Channels == "zRot";
            
            ind = x + y + z;
            assert(sum(ind) == 3,"Channel definition error in skeleton.");
            ind = find(ind);
            
            data = obj.Data(joint);
            data = data(:,ind);
        end
    end
    
    methods (Access = private)
        fLines = ImportAMC(filepath);
        obj = ParseAMC(obj, fLines);
    end
end

