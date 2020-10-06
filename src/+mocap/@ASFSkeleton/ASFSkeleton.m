classdef (Sealed) ASFSkeleton < handle
    %ASFSKELETON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Version
        Name
        Mass
        Length
        Angle
        Joints
        HierarchyMap
        Description
    end
    
    methods
        function obj = ASFSkeleton(filepath)
            %ASFSKELETON Construct an instance of this class
            %   Detailed explanation goes here
            obj.Joints = containers.Map('KeyType','double','ValueType','any');
            obj.HierarchyMap = containers.Map('KeyType','char','ValueType','int32');
            
            fLines = ImportASF(filepath);
            ParseASF(obj,fLines);
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
    
    methods (Access = private)
        fLines = ImportASF(filepath);
        ParseASF(obj, fLines); %Handle Super - No Output Required
    end
end

