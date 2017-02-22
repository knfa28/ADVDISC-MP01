function varargout = Interface(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Globals - start
function setObjectVal(arr)
    global objectVal;
    objectVal = arr;
 
function arr = getObjectVal
    global objectVal;
    arr = objectVal;
    
function setTransformVal(arr)
    global transformVal;
    transformVal = arr;
    
function arr = getTransformVal
    global transformVal;
    arr = transformVal;

function setCurrObject(val)
    global currObject;
    currObject = val;
    
function val = getCurrObject
    global currObject;
    val = currObject;
    
function setCurrFunc(val)
    global currFunc;
    currFunc = val;
    
 function val = getCurrFunc
    global currFunc;
    val = currFunc;
    
 function y = degtorad(x)
y = x * pi/180;

function addVertex(matrix)
     global polygon;
     polygon = vertcat(polygon, matrix);

function resetCnt
    global vertexCnt
    vertexCnt = 0;
    resetList;

function addCnt
    global vertexCnt
    vertexCnt = vertexCnt + 1;
    
function num = getCnt
    global vertexCnt
    num = vertexCnt;
    
function addToList(x, y, handles)
    global vertexList
    text{1} = '[';
    text{2} = num2str(x);
    text{3} = ', ';
    text{4} = num2str(y);
    text{5} = ']';
    temp = strcat(text{1}, text{2});
    temp = strcat(temp, text{3});
    temp = strcat(temp, text{4});
    temp = strcat(temp, text{5});
    addCnt;
    vertexList{getCnt} = temp;
    if(getCnt == 0)
        resetList;
        set(handles.polygon_list,'String',' ');
    else
        set(handles.polygon_list,'String',vertexList);
    end
    
 function resetList
     global vertexList
     clearvars -global vertexList polygon;
     
function r = getVertex
     global polygon;
     r = polygon;
% --- Globals - end  


% --- Interface Stuff - start
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
clearvars -global polygon
guidata(hObject, handles);

function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% --- Interface Stuff - end

% --- Callback - start
% Initialize Axes
cla reset;
a = [0, 0];
y = [100, 0];
plot(a ,y ,'k');
hold on;
plot(a, -1 * y, 'k');
a = [100, 0];
y = [0,0];
plot(a, y,'k');
plot(-1*a,y,'k');
axis([-100, 100, -100, 100]);
set(handles.verHyperbola_button,'Value', 1);	
set(handles.verParabola_button,'Value', 1);			
set(handles.cc90Rotate_button,'Value', 1);			
set(handles.xReflect_button,'Value', 1);
resetCnt;

% Combo Boxes
function createObject_combo_Callback(hObject, eventdata, handles)
    contents = get(handles.createObject_combo,'String'); 
    objectType = contents{get(handles.createObject_combo,'Value')};
    setObject(objectType, handles);
    resetCnt;
    
function transform_combo_Callback(hObject, eventdata, handles)
    contents = get(handles.transform_combo,'String'); 
    functionType = contents{get(handles.transform_combo,'Value')};
    setFunction(functionType, handles);
    resetCnt;
    
% Buttons
function addVertex_button_Callback(hObject, eventdata, handles)
    prompt = {'X-coordinate', 'Y-coordinate'};
    dlg_title = 'Add a Vertex';
    num_lines = [1 40;1 40];
    defaultans = {'', ''};
    answer = inputdlg(prompt, dlg_title, num_lines, defaultans);
    [x, y] = deal(answer{:});
    if(not(isempty(x)) || not(isempty(y)))
        x = str2num(x);
        y = str2num(y);
        matrix = [x y];
        addVertex(matrix);
        addToList(x, y, handles);
    end
     
function createObject_button_Callback(hObject, eventdata, handles)
    plotObject(getCurrObject, handles);
    resetCnt;
    resetList;

function original_button_Callback(hObject, eventdata, handles)
    cla reset;
    setAxes;
    restoreOriginal(getCurrObject, handles);
    resetCnt;
    
function clearAxes_button_Callback(hObject, eventdata, handles)
    cla reset;
    setAxes;
    resetCnt;
    
function trasformObject_button_Callback(hObject, eventdata, handles)
    func = getTransform(getCurrFunc, handles);
    transformObject(getCurrObject, getCurrFunc, func, handles);
    resetCnt;
    
% Values List
function original_list_Callback(hObject, eventdata, handles)
function transform_list_Callback(hObject, eventdata, handles)
    
% Point
function xPoint_field_Callback(hObject, eventdata, handles)
function yPoint_field_Callback(hObject, eventdata, handles)

% Vector
function xVector_field_Callback(hObject, eventdata, handles)
function yVector_field_Callback(hObject, eventdata, handles)

% Line Segment
function x1Segment_field_Callback(hObject, eventdata, handles)
function y1Segment_field_Callback(hObject, eventdata, handles)
function x2Segment_field_Callback(hObject, eventdata, handles)
function y2Segment_field_Callback(hObject, eventdata, handles)

% Polygon
function polygon_list_Callback(hObject, eventdata, handles)

% Hyperbola
function xHyperbola_field_Callback(hObject, eventdata, handles)
function yHyperbola_field_Callback(hObject, eventdata, handles)
    
function verDistHyperbola_field_Callback(hObject, eventdata, handles)
    
function horDistHyperbola_field_Callback(hObject, eventdata, handles)
   
function verHyperbola_button_Callback(hObject, eventdata, handles)
     set(handles.horHyperbola_button,'Value', 0);
function horHyperbola_button_Callback(hObject, eventdata, handles)
    set(handles.verHyperbola_button,'Value', 0);

% Parabola
function xParabola_field_Callback(hObject, eventdata, handles)
function yParabola_field_Callback(hObject, eventdata, handles)
function magParabola_field_Callback(hObject, eventdata, handles)
function verParabola_button_Callback(hObject, eventdata, handles)
    set(handles.horParabola_button,'Value', 0);
function horParabola_button_Callback(hObject, eventdata, handles)
    set(handles.verParabola_button,'Value', 0);

% Ellipse
function xEllipse_field_Callback(hObject, eventdata, handles)
function yEllipse_field_Callback(hObject, eventdata, handles)
function verDistEllipse_field_Callback(hObject, eventdata, handles)
function horDistEllipse_field_Callback(hObject, eventdata, handles)

% Translate
function xTranslate_field_Callback(hObject, eventdata, handles)
function yTranslate_field_Callback(hObject, eventdata, handles)

% Dynamic Rotate
function dRotate_field_Callback(hObject, eventdata, handles)

% Static Rotate
function cc90Rotate_button_Callback(hObject, eventdata, handles)
    set(handles.c90Rotate_button,'Value', 0);	
    set(handles.halfRotate_button,'Value', 0);
function c90Rotate_button_Callback(hObject, eventdata, handles)
    set(handles.cc90Rotate_button,'Value', 0);	
    set(handles.halfRotate_button,'Value', 0);
function halfRotate_button_Callback(hObject, eventdata, handles)
    set(handles.cc90Rotate_button,'Value', 0);	
    set(handles.c90Rotate_button,'Value', 0);

% Shear
function shear_field_Callback(hObject, eventdata, handles)

% Scale
function scale_field_Callback(hObject, eventdata, handles)

% Reflect
function xReflect_button_Callback(hObject, eventdata, handles)
    set(handles.yReflect_button,'Value', 0);
function yReflect_button_Callback(hObject, eventdata, handles)
    set(handles.xReflect_button,'Value', 0);
% --- Callback - end


% --- CreateFcn - start
% Combo Boxes
function createObject_combo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function transform_combo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Values Lists
function original_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function transform_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Point
function xPoint_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function yPoint_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Vector
function xVector_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function yVector_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Line Segment
function x1Segment_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function y1Segment_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function x2Segment_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function y2Segment_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Polygon
function polygon_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Hyperbola
function xHyperbola_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function yHyperbola_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function horDistHyperbola_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function verDistHyperbola_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Parabola
function xParabola_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function yParabola_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function magParabola_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Ellipse
function xEllipse_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function yEllipse_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function horDistEllipse_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function verDistEllipse_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Translate
function xTranslate_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function yTranslate_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Dynamic Rotate
function dRotate_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Shear
function shear_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Scale
function scale_field_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- CreateFcn - end

% --- Custom Functions - start
function setAxes
    a = [0, 0];
    y = [100, 0];
    plot(a ,y ,'k');
    hold on;
    plot(a, -1 * y, 'k');
    a = [100, 0];
    y = [0,0];
    plot(a, y,'k');
    plot(-1*a,y,'k');
    axis([-100, 100, -100, 100]);
    
    
function setObjectFunctions(objectType, handles)
    set(handles.transform_combo, 'String', 'Select Method');
    set(handles.transform_combo, 'value', 1);
    
    points{1} = 'Select Method';
    points{2} = 'Translate';
    
    polygons{1} = 'Select Method';
    polygons{2} = 'Translate';
    polygons{3} = 'Dynamic Rotate';
    polygons{4} = 'Static Rotate';
    polygons{5} = 'Shear';
    polygons{6} = 'Scale';
    polygons{7} = 'Reflect';
    
    conics{1} = 'Select Method';
    conics{2} = 'Translate';
    conics{3} = 'Dynamic Rotate';
    conics{4} = 'Static Rotate';
    conics{5} = 'Shear';
    conics{6} = 'Scale';
    conics{7} = 'Reflect';
    
    switch(objectType)
        case 'Point'
            set(handles.transform_combo, 'String', points);
        case 'Vector'
            set(handles.transform_combo, 'String', polygons);
        case 'Line Segment'
            set(handles.transform_combo, 'String', polygons);
        case 'Polygon'
            set(handles.transform_combo, 'String', polygons);
        case 'Parabola'
            set(handles.transform_combo, 'String', conics);
        case 'Hyperbola'
            set(handles.transform_combo, 'String', conics);
        case 'Ellipse'
            set(handles.transform_combo, 'String', conics);          
    end
    
    setFunction('Select Method', handles);
    
function setObject(objectType, handles)
    setCurrObject(objectType);

    set(handles.noObject_panel, 'visible', 'off');
    set(handles.createPoint_panel, 'visible', 'off');
    set(handles.createVector_panel, 'visible', 'off');
    set(handles.createSegment_panel, 'visible', 'off');
    set(handles.createPolygon_panel, 'visible', 'off');
    set(handles.createParabola_panel, 'visible', 'off');
    set(handles.createHyperbola_panel, 'visible', 'off');
    set(handles.createEllipse_panel, 'visible', 'off');
    
    switch(objectType)
        case 'Point'
            set(handles.createPoint_panel, 'visible', 'on');
        case 'Vector'
            set(handles.createVector_panel, 'visible', 'on');
        case 'Line Segment'
            set(handles.createSegment_panel, 'visible', 'on');
        case 'Polygon'
            set(handles.createPolygon_panel, 'visible', 'on');
        case 'Parabola'
            set(handles.createParabola_panel, 'visible', 'on');
        case 'Hyperbola'
            set(handles.createHyperbola_panel, 'visible', 'on');
        case 'Ellipse'
            set(handles.createEllipse_panel, 'visible', 'on');
        case 'Select Object'
            set(handles.noObject_panel, 'visible', 'on');                 
    end
    
    setObjectFunctions(objectType, handles);
    
function setFunction(functionType, handles)
    setCurrFunc(functionType);

    set(handles.noMethod_panel, 'visible', 'off');
    set(handles.translate_panel, 'visible', 'off');
    set(handles.dRotate_panel, 'visible', 'off');
    set(handles.sRotate_panel, 'visible', 'off');
    set(handles.shear_panel, 'visible', 'off');
    set(handles.scale_panel, 'visible', 'off');
    set(handles.reflect_panel, 'visible', 'off');

    switch(functionType)
        case 'Translate'
            set(handles.translate_panel, 'visible', 'on');
        case 'Dynamic Rotate'
            set(handles.dRotate_panel, 'visible', 'on');
        case 'Static Rotate'
            set(handles.sRotate_panel, 'visible', 'on');
        case 'Shear'
            set(handles.shear_panel, 'visible', 'on');
        case 'Scale'
            set(handles.scale_panel, 'visible', 'on');
        case 'Reflect'
            set(handles.reflect_panel, 'visible', 'on');
        case 'Select Method'
            set(handles.noMethod_panel, 'visible', 'on');
            set(handles.noMethod_label, 'String', 'Select Method');
    end
    
function plotObject(objectType, handles)
    switch(objectType)
        case 'Point'
            x = str2double(get(handles.xPoint_field,'String'));
            y = str2double(get(handles.yPoint_field,'String'));
            
            objectVal{1} = x;
            objectVal{2} = y;
            plotData = scatter(x, y, 25, 'blue', 'filled');
            setList(x, y, 1, handles);    
          
        case 'Vector'
            x = str2double(get(handles.xVector_field,'String'));
            y = str2double(get(handles.yVector_field,'String'));
            
            objectVal = [0 0;x y];
            plotData = plot([x 0], [y, 0]);
            setList([x 0], [y 0], 1, handles);
             
        case 'Line Segment'
            x1 = str2double(get(handles.x1Segment_field,'String'));
            y1 = str2double(get(handles.y1Segment_field,'String'));
            x2 = str2double(get(handles.x2Segment_field,'String'));
            y2 = str2double(get(handles.y2Segment_field,'String'));
            
            %objectVal{1} = x1;
            %objectVal{2} = y1;
            %objectVal{3} = x2;
            %objectVal{4} = y2;
            objectVal = [x1 y1; x2 y2]
            plotData = plot([x1;y1], [x2;y2], 'blue');
            setList([x1;y1], [x2;y2], 1, handles);
            
        case 'Polygon'
            polygon = getVertex;
            objectVal = polygon;
            pLength = length(polygon)+1;
            polygon(pLength,:)=polygon(1,:);
            polygon
            plotData = patch(polygon(:,1), polygon(:,2), 'black');
            setList(polygon(:,1), polygon(:,2), 1, handles);
        case 'Parabola'
            xVertex = str2double(get(handles.xParabola_field,'String'));
            yVertex = str2double(get(handles.yParabola_field,'String'));
            mag = str2double(get(handles.magParabola_field,'String'));
            
            if (get(handles.verParabola_button,'Value') == 1)
                x = -100:1:100;
                y = (x - xVertex).^2/mag + yVertex;
                plotData = plot(x, y, 'blue'); 
                orient = 1;
            
            elseif (get(handles.horParabola_button,'Value') == 1)
                y = -100:1:100
                x = (y - yVertex).^2/mag + xVertex;
                plotData = plot(x, y ,'blue');
                orient = 0;
            end
            
            setList(x, y, 1, handles);
            objectVal{1} = xVertex;
            objectVal{2} = yVertex;
            objectVal{3} = mag;
            objectVal{4} = orient; 
            
        case 'Hyperbola'
            xCenter = str2double(get(handles.xHyperbola_field,'String'));
            yCenter = str2double(get(handles.yHyperbola_field,'String'));
            verDist = str2double(get(handles.verDistHyperbola_field,'String'));
            horDist = str2double(get(handles.horDistHyperbola_field,'String'));
            x = -100:1:100;
            
            objectVal{1} = xCenter;
            objectVal{2} = yCenter;
            objectVal{3} = verDist;
            objectVal{4} = horDist;
            
            if (get(handles.horHyperbola_button,'Value') == 1)
                y = sqrt(verDist.^2 * (x-xCenter).^2 / horDist.^2 - verDist.^2) + yCenter;     
                plotData{1} = plot(x, y);
                plotData{2} = plot(x, -y);
                orient = 1;
            elseif (get(handles.verHyperbola_button,'Value') == 1)
                y = sqrt(horDist.^2 * (x-xCenter).^2 / verDist.^2 + horDist.^2 ) + yCenter;
                plotData{1} = plot(x, y);
                plotData{2} = plot(x, -y);
                orient = 0;
            end
                        objectVal{5} = orient;
                        setList(x, y, 1, handles);
            
        case 'Ellipse'
            xCenter = str2double(get(handles.xEllipse_field,'String'));
            yCenter = str2double(get(handles.yEllipse_field,'String'));
            verDist = str2double(get(handles.verDistEllipse_field,'String'));
            horDist = str2double(get(handles.horDistEllipse_field,'String'));
            
            t = -pi:0.01:pi;
            x = xCenter + horDist * cos(t);
            y = yCenter + verDist * sin(t);
            
            objectVal{1} = xCenter;
            objectVal{2} = yCenter;
            objectVal{3} = verDist;
            objectVal{4} = horDist;
            plotData = plot(x,y);
            setList(x, y, 1, handles);
            
        case 'Select Object'
            set(handles.noObject_panel, 'visible', 'on');                 
    end
    
    setObjectVal(objectVal);
%    set(plotData,'Parent', handles.main_axes);

function func = getTransform(functionType, handles)
    switch(functionType)
        case 'Translate'
            transformVal{1} = str2double(get(handles.xTranslate_field, 'String'));
            transformVal{2} = str2double(get(handles.yTranslate_field, 'String'));
            func = 1;
                 
        case 'Dynamic Rotate'
            transformVal{1} = str2double(get(handles.dRotate_field, 'String'));
            func = 2;
            
        case 'Static Rotate'
            if (get(handles.cc90Rotate_button,'Value') == 1)
                func = 3;
                transformVal{1} = -90;
            elseif (get(handles.c90Rotate_button,'Value') == 1)
                func = 4;
                transformVal{1} = 90;
            elseif (get(handles.halfRotate_button,'Value') == 1)
                func = 5;
                transformVal{1} = 180;
            end
            
        case 'Shear'
            transformVal{1} = str2double(get(handles.shear_field, 'String'));
            func = 6;
             
        case 'Scale'
            transformVal{1} = str2double(get(handles.scale_field, 'String'));
            func = 7;
            
        case 'Reflect'
            if (get(handles.xReflect_button,'Value') == 1)
                func = 8;
                transformVal{1} = [1 0; 0 -1];
            elseif (get(handles.yReflect_button,'Value') == 1)
                transformVal{1} = [-1 0; 0 1];
                func = 9;
            end
            
        case 'Select Method'
           setFunction('Select Method', handles);
           func = 0;
    end
    
    setTransformVal(transformVal);

function plotData = translatePoint(objectVals, transformVal, func, handles)
    if(func == 1)
        x = objectVals{1} + transformVal{1};
        y = objectVals{2} + transformVal{2};
        
        plotData = scatter(x, y, 25, 'green', 'filled');
        setList(x, y, 0, handles);
    end
    
function plotData = translateSegment(objectVal, transformVal, func, handles)
        transSeg = objectVal + transformVal{1};
        plotData = plot(transSeg(:,1), transSeg(:,2), 'red');
        setList(transSeg(:,1), transSeg(:,2), 0, handles);
    
function plotData = translateVector(objectVal, transformVal, func, handles)
        transVec = objectVal + transformVal{1}
        plotData = plot(transVec(:,1), transVec(:,2), 'red')
        setList(transVec(:,1), transVec(:,2), 0, handles);
        
 function plotData = sRotateSegment(objectVal, transformVal, func, handles)
     transformVal
     theta = degtorad(transformVal{1});
     dRotateMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
     dRotateSeg = objectVal * dRotateMatrix
     plotData = plot(dRotateSeg(:,1), dRotateSeg(:,2), 'red');
     setList(dRotateSeg(:,1), dRotateSeg(:,2), 0, handles);
     
 function plotData = dRotateSegment(objectVal, transformVal, func, handles)
        theta = degtorad(transformVal{1});
        dRotateMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
        dRotateSeg = objectVal * dRotateMatrix
        plotData = plot(dRotateSeg(:,1), dRotateSeg(:,2), 'red');
        setList(dRotateSeg(:,1), dRotateSeg(:,2), 0, handles);
  
function plotData = shearSegment(objectVal, transformVal, func, handles)
    theta = degtorad(transformVal{1});
    dRotateMatrix = [1 0; tan(theta) 1];
    dShearSeg = objectVal * dRotateMatrix
    plotData = plot(dShearSeg(:,1), dShearSeg(:,2), 'red')
    setList(dShearSeg(:,1), dShearSeg(:,2), 0, handles);
    
function plotData = reflectSegment(objectVal, transformVal, func, handles)
    if(func == 8)
        reflectOnX = [1 0; 0 -1];
        dReflectSeg = objectVal * reflectOnX;
        plotData = plot(dReflectSeg(:,1), dReflectSeg(:,2), 'red')
    elseif(func == 9) 
        reflectOnY = [-1 0; 0 1];
        dReflectSeg = objectVal * reflectOnY;
        plotData = plot(dReflectSeg(:,1), dReflectSeg(:,2), 'red')
    end
    setList(dReflectSeg(:,1), dReflectSeg(:,2), 0, handles);
    
function plotData = dRotatePolygon(objectVal, transformVal, func, handles)
        theta = degtorad(transformVal{1});
        dRotateMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
        dRotatePol = objectVal * dRotateMatrix;
        plotData = patch(dRotatePol(:,1), dRotatePol(:,2), 'red');
        setList(dRotatePol(:,1), dRotatePol(:,2), 0, handles);
        
function plotData = sRotatePolygon(objectVal, transformVal, func, handles)
        theta = degtorad(transformVal{1});
        dRotateMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
        dRotatePol = objectVal * dRotateMatrix;
        plotData = patch(dRotatePol(:,1), dRotatePol(:,2), 'red');
        setList(dRotatePol(:,1), dRotatePol(:,2), 0, handles);
        
function plotData = translatePolygon(objectVal, transformVal, func, handles)
        transPol = objectVal + transformVal{1};
        plotData = patch(transPol(:,1), transPol(:,2), 'red');
        setList(transPol(:,1), transPol(:,2), 0, handles);
        
function plotData = reflectPolygon(objectVal, transformVal, func, handles)
    func
    if(func == 9)
        reflectOnX = [1 0; 0 -1];
        dReflectPol = objectVal * reflectOnX
        plotData = patch(dReflectPol(:,1), dReflectPol(:,2), 'red');
    elseif(func == 8)
        reflectOnY = [-1 0; 0 1];
        dReflectPol = objectVal * reflectOnY
        plotData = patch(dReflectPol(:,1), dReflectPol(:,2), 'red');
    end
    setList(dReflectPol(:,1), dReflectPol(:,2), 0, handles);
    
 function plotData = scaleVector(objectVal, transformVal, func, handles)
    scaled = objectVal * transformVal{1};
    plotData = plot(scaled(:,1), scaled(:,2), 'red')
    setList(scaled(:,1), scaled(:,2), 0, handles);
    
function plotData = dRotateVector(objectVal, transformVal, func, handles)
    theta = degtorad(transformVal{1});
    dRotateMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    dRotateVec = objectVal * dRotateMatrix
    plotData = plot(dRotateVec(:,1), dRotateVec(:,2), 'red');
    setList(dRotateVec(:,1), dRotateVec(:,2), 0, handles);
    
function plotData = sRotateVector(objectVal, transformVal, func, handles)
    theta = degtorad(transformVal{1});
    dRotateMatrix = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    dRotateVec = objectVal * dRotateMatrix
    plotData = plot(dRotateVec(:,1), dRotateVec(:,2), 'red');
    setList(dRotateVec(:,1), dRotateVec(:,2), 0, handles);
    
function plotData = reflectVector(objectVal, transformVal, func, handles)
    if(func == 8)
        reflectOnX = [1 0; 0 -1];
        dReflectVec = objectVal * reflectOnX
        plotData = plot(dReflectVec(:,1), dReflectVec(:,2), 'red');
    elseif(func == 9)
        reflectOnY = [-1 0; 0 1];
        dReflectVec = objectVal * reflectOnY
        plotData = plot(dReflectVec(:,1), dReflectVec(:,2), 'red');
    end
    setList(dReflectVec(:,1), dReflectVec(:,2), 0, handles);
    
 function plotData = shearVector(objectVal, transformVal, func, handles)
        theta = degtorad(transformVal{1});
        dRotateMatrix = [1 0; tan(theta) 1];
        dShearVec = objectVal * dRotateMatrix
        plotData = plot(dShearVec(:,1), dShearVec(:,2), 'red');
        setList(dShearVec(:,1), dShearVec(:,2), 0, handles);
        
 function plotData = shearPolygon(objectVal, transformVal, func, handles)
        theta = degtorad(transformVal{1});
        dRotateMatrix = [1 0; tan(theta) 1];
        dShearPol = objectVal * dRotateMatrix
        plotData = patch(dShearPol(:,1), dShearPol(:,2), 'red')
        setList(dShearPol(:,1), dShearPol(:,2), 0, handles);
    
function plotData = scaleSegment(objectVal, transformVal, func, handles)
    scaled = objectVal * transformVal{1};
    plotData = plot(scaled(:,1), scaled(:,2), 'red')
    setList(scaled(:,1), scaled(:,2), 0, handles);

function plotData = scalePolygon(objectVal, transformVal, func, handles)
    scaled = objectVal * transformVal{1};
    plotData = patch(scaled(:,1), scaled(:,2), 'red')
    setList(scaled(:,1), scaled(:,2), 0, handles);
    
function plotData = translateParabola(objectVal, transformVal, func, handles)
        x = -100:1:100;
        mag = objectVal{3};
        xVertex = objectVal{1};
        yVertex = objectVal{2};
            
            if (objectVal{4} == 1)
                x = -100:1:100;
                y = (x - xVertex-transformVal{2}).^2/mag + yVertex+transformVal{1};
                plotData = plot(x, y, 'red'); 
                orient = 1;
            elseif (objectVal{4} == 0)
                y = -100:1:100
                x = (y - yVertex-transformVal{1}).^2/mag + xVertex+transformVal{2};
                plotData = plot(x, y, 'red');
                orient = 0;
            end
         setList(x, y, 0, handles);
        
function plotData = scaleParabola(objectVal, transformVal, func, handles)
    mag = objectVal{3} * transformVal{1};
    xVertex = objectVal{1};
    yVertex = objectVal{2};
            
    if (objectVal{4} == 1)
        x = -100:1:100;
        y = (x - xVertex).^2/mag + yVertex;
        plotData = plot(x, y, 'red'); 
        orient = 1;
    elseif (objectVal{4} == 0)
        y = -100:1:100
        x = (y - yVertex).^2/mag + xVertex;
        plotData = plot(x, y, 'red');
        orient = 0;
    end
    setList(x, y, 0, handles);
    
function plotData = sRotateParabola(objectVal, transformVal, func, handles)
    orient = objectVal{4};
    func
    if(func == 3)
        if(orient == 0)
        xVertex = objectVal{1};
        yVertex = objectVal{2};
        mag = objectVal{3};
        else
            xVertex = objectVal{1};
            yVertex = objectVal{2};
            mag = -objectVal{3};
        end
    elseif(func == 4)
        if(orient == 0)
            xVertex = objectVal{1};
            yVertex = objectVal{2};
            mag = objectVal{3};
        else
            xVertex = objectVal{1};
            yVertex = objectVal{2};
            mag = objectVal{3};
        end
    elseif(func == 5)
        if(orient == 0)           
            xVertex = objectVal{1};
            yVertex = objectVal{2};
            mag = -objectVal{3};
            orient = 1;
        else
            xVertex = objectVal{1};
            yVertex = objectVal{2};
            mag = -objectVal{3};
            orient = 0;
        end
    end
            
    if (orient == 0)
        x = -100:1:100;
        y = (x - xVertex).^2/mag + yVertex;
        plotData = plot(x, y, 'red'); 
    elseif (orient == 1)
        y = -100:1:100
        x = (y - yVertex).^2/mag + xVertex;
        plotData = plot(x, y, 'red');
    end
    setList(x, y, 0, handles);
    
function plotData = dRotateParabola(objectVal, transformVal, func, handles)
    if(func == 2)
        xVertex = objectVal{1};
        yVertex = objectVal{2};
        mag = objectVal{3};
        orient = objectVal{4}; 
            
        if (orient == 1)
            x = -100:1:100;
            y = (x - xVertex).^2/mag + yVertex;
            %plotData = plot(x, y, 'blue'); 
        elseif (orient == 1)
            y = -100:1:100;
            x = (y - yVertex).^2/mag + xVertex;
            %plotData = plot(x, y, 'blue');
        end
        
        tempMatrix = [x;
                      y];
        delta = degtorad(transformVal{1});
        rotationMatrix = [cos(delta),sin(delta);
                       sin(delta),cos(delta)];
        resultMatrix = rotationMatrix * tempMatrix;
        x = resultMatrix(1,:);
        y = resultMatrix(2,:);
        plotData = plot(x, y, 'red');
        setList(x, y, 0, handles);
    end
    
function plotData = shearParabola(objectVal, transformVal, func, handles)
        xVertex = objectVal{1};
        yVertex = objectVal{2};
        mag = objectVal{3};
        orient = objectVal{4}; 
            
        if (orient == 1)
            x = -100:1:100;
            y = (x - xVertex).^2/mag + yVertex;
            %plotData = plot(x, y, 'blue'); 
        elseif (orient == 1)
            y = -100:1:100;
            x = (y - yVertex).^2/mag + xVertex;
            %plotData = plot(x, y, 'blue');
        end
        
        tempMatrix = [x;
                      y];
        delta = degtorad(transformVal{1});
        shearMatrix = [1 tan(delta); 0 1];
        resultMatrix = shearMatrix * tempMatrix;
        x = resultMatrix(1,:);
        y = resultMatrix(2,:);
        plotData = plot(x, y, 'red');
        setList(x, y, 0, handles);
           
function plotData = dRotateEllipse(objectVal, transformVal, func, handles)
    if(func == 2)
        xCenter = objectVal{1};
        yCenter = objectVal{2};
        verDist = objectVal{3};
        horDist = objectVal{4};
            
        t = -pi:0.01:pi;
        x = xCenter + horDist * cos(t);
        y = yCenter + verDist * sin(t);
            
        tempMatrix = [x;
                      y];
        delta = transformVal{1};
        delta = delta*180/pi;
        rotationMatrix = [cos(delta),-sin(delta);
                           sin(delta),cos(delta)];
        resultMatrix = rotationMatrix * tempMatrix;
        x = resultMatrix(1,:);
        y = resultMatrix(2,:);
        
        plotData = plot(x, y, 'red');
        setList(x, y, 0, handles);
    end
    
function plotData = shearEllipse(objectVal, transformVal, func, handles)
        xCenter = objectVal{1};
        yCenter = objectVal{2};
        verDist = objectVal{3};
        horDist = objectVal{4};
            
        t = -pi:0.01:pi;
        x = xCenter + horDist * cos(t);
        y = yCenter + verDist * sin(t);
            
        tempMatrix = [x;
                      y];
        delta = transformVal{1};
        delta = delta*180/pi;
        shearMatrix = [1 tan(delta); 0 1];
        resultMatrix = shearMatrix * tempMatrix;
        x = resultMatrix(1,:);
        y = resultMatrix(2,:);
        
        plotData = plot(x, y, 'red');
        setList(x, y, 0, handles);

function plotData = dRotateHyperbola(objectVal, transformVal, func, handles)
    if(func == 2)
        objectVal
        xCenter = objectVal{1};
        yCenter = objectVal{2};
        verDist = objectVal{3};
        horDist = objectVal{4};
        orient = objectVal{5}; 
        x = -100:1:100;
            
        if (orient == 0)
            y = sqrt(verDist.^2 * (x-xCenter).^2 / horDist.^2 - verDist.^2) + yCenter;          
        elseif (orient == 1)
            y = sqrt(horDist.^2 * (x-xCenter).^2 / verDist.^2 + horDist.^2 ) + yCenter;
        end 
            
        tempMatrix = [x;
                      y];
        delta = transformVal{1};
        delta = delta*180/pi;
        rotationMatrix = [cos(delta),-sin(delta);
                           sin(delta),cos(delta)];
        resultMatrix = rotationMatrix * tempMatrix;
        x = resultMatrix(1,:);
        y = resultMatrix(2,:);
        
        plotData{1} = plot(x, y, 'red');
        plotData{2} = plot(x, -y, 'red');
        setList(x, y, 0, handles);
    end
    
function plotData = sRotateHyperbola(objectVal, transformVal, func, handles)
        objectVal
        xCenter = objectVal{1};
        yCenter = objectVal{2};
        verDist = objectVal{3};
        horDist = objectVal{4};
        orient = objectVal{5}; 
        x = -100:1:100;
            
        if (orient == 0)
            y = sqrt(verDist.^2 * (x-xCenter).^2 / horDist.^2 - verDist.^2) + yCenter;          
        elseif (orient == 1)
            y = sqrt(horDist.^2 * (x-xCenter).^2 / verDist.^2 + horDist.^2 ) + yCenter;
        end 
            
        tempMatrix = [x;
                      y];
        delta = transformVal{1};
        delta = delta*180/pi;
        rotationMatrix = [cos(delta),-sin(delta);
                           sin(delta),cos(delta)];
        resultMatrix = rotationMatrix * tempMatrix;
        x = resultMatrix(1,:);
        y = resultMatrix(2,:);
        
        plotData{1} = plot(x, y, 'red');
        plotData{2} = plot(x, -y, 'red');
        setList(x, y, 0, handles);
    

    
function plotData = shearHyperbola(objectVal, transformVal, func, handles)
        xCenter = objectVal{1};
        yCenter = objectVal{2};
        verDist = objectVal{3};
        horDist = objectVal{4};
        orient = objectVal{5}; 
        x = -100:1:100;
            
        if (orient == 0)
            y = sqrt(verDist.^2 * (x-xCenter).^2 / horDist.^2 - verDist.^2) + yCenter;          
        elseif (orient == 1)
            y = sqrt(horDist.^2 * (x-xCenter).^2 / verDist.^2 + horDist.^2 ) + yCenter;
        end 
            
        tempMatrix = [x;
                      y];
        delta = transformVal{1};
        delta = delta*180/pi;
        shearMatrix = [1 tan(delta); 0 1];
        resultMatrix = shearMatrix * tempMatrix;
        x = resultMatrix(1,:);
        y = resultMatrix(2,:);
        
        plotData{1} = plot(x, y, 'red');
        plotData{2} = plot(x, -y, 'red');
        setList(x, y, 0, handles);
    
function plotData = translateHyperbola(objectVal, transformVal, func, handles)
    if(func == 1)
        xCenter = objectVal{1} + transformVal{1};
        yCenter = objectVal{2} + transformVal{2};
        verDist = objectVal{3};
        horDist = objectVal{4};
        orient = objectVal{5}; 
        x = -100:1:100;
            
        if (orient == 0)
            y = sqrt(verDist.^2 * (x-xCenter).^2 / horDist.^2 - verDist.^2) + yCenter;     
            plotData{1} = plot(x, y);
            plotData{2} = plot(x, -y);
        elseif (orient == 1)
            y = sqrt(horDist.^2 * (x-xCenter).^2 / verDist.^2 + horDist.^2 ) + yCenter;
            plotData{1} = plot(x, y);
            plotData{2} = plot(x, -y);
        end
        setList(x, y, 0, handles);
    end
    
function plotData = scaleHyperbola(objectVal, transformVal, func, handles)
    if(func == 7)
        xCenter = objectVal{1};
        yCenter = objectVal{2};
        verDist = objectVal{3} * transformVal{1};
        horDist = objectVal{4} * transformVal{1};
        orient = objectVal{5}; 
        x = -100:1:100;
            
        if (orient == 0)
            y = sqrt(verDist.^2 * (x-xCenter).^2 / horDist.^2 - verDist.^2) + yCenter;     
            plotData{1} = plot(x, y);
            plotData{2} = plot(x, -y);
        elseif (orient == 1)
            y = sqrt(horDist.^2 * (x-xCenter).^2 / verDist.^2 + horDist.^2 ) + yCenter;
            plotData{1} = plot(x, y);
            plotData{2} = plot(x, -y);
        end 
        setList(x, y, 0, handles);
    end
    
function plotData = reflectParabola(objectVal, transformVal, func, handles)
    if(func == 8)
        if(objectVal{4} == 0)
            xVertex = objectVal{1};
            yVertex = -objectVal{2};
            mag = -objectVal{3};
            orient = 1;
        else
            xVertex = objectVal{1};
            yVertex = -objectVal{2};
            mag = objectVal{3};
            orient = 0;
        end
    elseif(func == 9)
        if(objectVal{4} == 0)
            xVertex = -objectVal{1};
            yVertex = objectVal{2};
            mag = objectVal{3};
            orient = 1;
        else
            xVertex = objectVal{1};
            yVertex = objectVal{2};
            mag = -objectVal{3};
            orient = 0;
        end
    end
            
    if (orient == 0)
        x = -100:1:100;
        y = (x - xVertex).^2/mag + yVertex;
        plotData = plot(x, y, 'red'); 
    elseif (orient == 1)
        y = -100:1:100;
        x = (y - yVertex).^2/mag + xVertex;
        plotData = plot(x, y, 'red');
    end 
    setList(x, y, 0, handles);
    
 function plotData = reflectHyperbola(objectVal, transformVal, func, handles)
    orient = objectVal{5};
    
    if(func == 8)
        xCenter = objectVal{1};
        yCenter = -objectVal{2};
        verDist = objectVal{3};
        horDist = objectVal{4}; 
        x = -100:1:100;
    elseif(func == 9)
        xCenter = -objectVal{1};
        yCenter = objectVal{2};
        verDist = objectVal{3};
        horDist = objectVal{4}; 
        x = -100:1:100;
    end
            
    if (orient == 0)
        y = sqrt(verDist.^2 * (x-xCenter).^2 / horDist.^2 - verDist.^2) + yCenter;     
        plotData{1} = plot(x, y);
        plotData{2} = plot(x, -y);
    elseif (orient == 1)
        y = sqrt(horDist.^2 * (x-xCenter).^2 / verDist.^2 + horDist.^2 ) + yCenter;
        plotData{1} = plot(x, y);
        plotData{2} = plot(x, -y);
    end
    setList(x, y, 0, handles);
    
 function plotData = reflectEllipse(objectVal, transformVal, func, handles)
     if(func == 8)
         xCenter = objectVal{1};
         yCenter = -objectVal{2};
         verDist = objectVal{3};
         horDist = objectVal{4};
     elseif(func == 9)
         xCenter = -objectVal{1};
         yCenter = objectVal{2};
         verDist = objectVal{3};
         horDist = objectVal{4};
     end
     
     t = -pi:0.01:pi;
     x = xCenter + horDist * cos(t);
     y = yCenter + verDist * sin(t);
            
     plotData = plot(x,y, 'red');
     setList(x, y, 0, handles);

 function plotData = translateEllipse(objectVal, transformVal, func, handles)
     if(func == 1)
         xCenter = objectVal{1} + transformVal{1};
         yCenter = objectVal{2} + transformVal{2};
         verDist = objectVal{3};
         horDist = objectVal{4};
            
         t = -pi:0.01:pi;
         x = xCenter + horDist * cos(t);
         y = yCenter + verDist * sin(t);
            
         plotData = plot(x,y);
         setList(x, y, 0, handles);
     end
 
  function plotData = scaleEllipse(objectVal, transformVal, func, handles)
     if(func == 7)
         xCenter = objectVal{1};
         yCenter = objectVal{2};
         verDist = objectVal{3} * transformVal{1};
         horDist = objectVal{4} * transformVal{1};
            
         t = -pi:0.01:pi;
         x = xCenter + horDist * cos(t);
         y = yCenter + verDist * sin(t);
            
         plotData = plot(x,y);
         setList(x, y, 0, handles);
     end          
            
    
function transformObject(objectType, functionType, func, handles)
    objectVal = getObjectVal;
    transformVal = getTransformVal;
    
    switch(functionType)
        case 'Translate'
            if (strcmp(objectType, 'Point') == 1)
                plotData = translatePoint(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Vector') == 1)
                plotData = translateVector(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Line Segment') == 1)
                plotData = translateSegment(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Polygon') == 1)
                plotData = translatePolygon(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Parabola') == 1) 
                plotData = translateParabola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Hyperbola') == 1)
                plotData = translateHyperbola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Ellipse') == 1)
                plotData = translateEllipse(objectVal, transformVal, func, handles);
            end
            
        case 'Dynamic Rotate'
            if (strcmp(objectType, 'Vector') == 1)
                plotData = dRotateVector(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Line Segment') == 1)
                plotData = dRotateSegment(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Polygon') == 1)
                plotData = dRotatePolygon(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Parabola') == 1)
                plotData = dRotateParabola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Hyperbola') == 1)
                plotData = dRotateHyperbola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Ellipse') == 1)
                plotData = dRotateEllipse(objectVal, transformVal, func, handles);
            end
            
        case 'Static Rotate'
            if (strcmp(objectType, 'Vector') == 1)
                plotData = sRotateVector(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Line Segment') == 1)
                plotData = sRotateSegment(objectVal, transformVal, fun, handles);
            elseif (strcmp(objectType, 'Polygon') == 1)
                plotData = sRotatePolygon(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Parabola') == 1)
                plotData = sRotateParabola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Hyperbola') == 1)
                plotData = sRotateHyperbola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Ellipse') == 1)
                plotData = sRotateEllipse(objectVal, transformVal, func, handles);
            end
            
        case 'Shear'
            if (strcmp(objectType, 'Vector') == 1)
                plotData = shearVector(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Line Segment') == 1)
                plotData = shearSegment(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Polygon') == 1)
                plotData = shearPolygon(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Parabola') == 1)
                plotData = shearParabola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Hyperbola') == 1)
                plotData = shearHyperbola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Ellipse') == 1)
                plotData = shearEllipse(objectVal, transformVal, func, handles);
            end
            
        case 'Scale'
            if (strcmp(objectType, 'Vector') == 1)
                plotData = scaleVector(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Line Segment') == 1)
                plotData = scaleSegment(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Polygon') == 1)
                plotData = scalePolygon(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Parabola') == 1)
                plotData = scaleParabola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Hyperbola') == 1)
                plotData = scaleHyperbola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Ellipse') == 1)
                plotData = scaleEllipse(objectVal, transformVal, func, handles);
            end
            
        case 'Reflect'
            if (strcmp(objectType, 'Vector') == 1)
                plotData = reflectVector(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Line Segment') == 1)
                plotData = reflectSegment(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Polygon') == 1)
                plotData = reflectPolygon(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Parabola') == 1)
                plotData = reflectParabola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Hyperbola') == 1)
                plotData = reflectHyperbola(objectVal, transformVal, func, handles);
            elseif (strcmp(objectType, 'Ellipse') == 1)
                plotData = reflectEllipse(objectVal, transformVal, func, handles);
            end
    end
    
 function restoreOriginal(objectType, handles)
    objectVal = getObjectVal;
    
    switch(objectType)
        case 'Point'         
            x = objectVal{1};
            y = objectVal{2};
            plotData = scatter(x, y, 25, 'blue', 'filled');
          
        case 'Vector'
            x = objectVal(3);
            y = objectVal(4);
            plotData = plot([x 0], [y, 0]);
             
        case 'Line Segment'
            x1 = objectVal(1);
            y1 = objectVal(2);
            x2 = objectVal(3);
            y2 = objectVal(4);
            plotData = plot([x1;y1], [x2;y2], 'blue');
            
        case 'Polygon'
            polygon = objectVal;
            pLength = length(polygon)+1;
            polygon(pLength,:)=polygon(1,:);
            plotData = patch(polygon(:,1), polygon(:,2), 'black');
            
        case 'Parabola'
            xVertex = objectVal{1};
            yVertex = objectVal{2};
            mag = objectVal{3};
            orient = objectVal{4}; 
            
            if (orient == 1)
                x = -100:1:100;
                y = (x - xVertex).^2/mag + yVertex;
                plotData = plot(x, y, 'blue'); 
            elseif (orient == 1)
                y = -100:1:100;
                x = (y - yVertex).^2/mag + xVertex;
                plotData = plot(x, y, 'blue');
            end
               
        case 'Hyperbola'
            xCenter = objectVal{1};
            yCenter = objectVal{2};
            verDist = objectVal{3};
            horDist = objectVal{4};
            orient = objectVal{5}; 
            x = -100:1:100;
            
            if (orient == 0)
                y = sqrt(verDist.^2 * (x-xCenter).^2 / horDist.^2 - verDist.^2) + yCenter;     
                plotData{1} = plot(x, y);
                plotData{2} = plot(x, -y);
            elseif (orient == 1)
                y = sqrt(horDist.^2 * (x-xCenter).^2 / verDist.^2 + horDist.^2 ) + yCenter;
                plotData{1} = plot(x, y);
                plotData{2} = plot(x, -y);
            end         
            
        case 'Ellipse'
            xCenter = objectVal{1};
            yCenter = objectVal{2};
            verDist = objectVal{3};
            horDist = objectVal{4};
            
            t = -pi:0.01:pi;
            x = xCenter + horDist * cos(t);
            y = yCenter + verDist * sin(t);
            
            plotData = plot(x,y);
            
        case 'Select Object'
            set(handles.noObject_panel, 'visible', 'on');                 
    end
    
function setList(x, y, check, handles)
    xSize = size(x)
    for i=1:xSize(:,2)
        text{1} = '[';
        text{2} = num2str(x(i));
        text{3} = ', ';
        text{4} = num2str(y(i));
        text{5} = ']'
        temp = strcat(text{1}, text{2});
        temp = strcat(temp, text{3});
        temp = strcat(temp, text{4});
        temp = strcat(temp, text{5});
        value{i} = temp;
    end
    
    if(check == 1)
        set(handles.original_list,'String',value)
    else
        set(handles.transform_list,'String',value)
    end
            
% --- Custom Functions - end

