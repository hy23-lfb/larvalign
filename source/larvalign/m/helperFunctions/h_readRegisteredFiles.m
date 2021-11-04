function [t, org, lin, nonlin] = h_readRegisteredFiles(value)
%%
%% read template files to an array.
%%
%% Author: Harsha Yogeshappa
%%

t = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D5_Template.tif');

%% D3 images
if (value == 3)
    fprintf("Providing D3 Results vs D5 as template.\n");
    d3 = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D3_Before_Registration.tif');
    l_ = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D3_After_LinearRegistration.tif');
    nl_ = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D3_After_Registration.tif');
    
    org = d3; lin = l_; nonlin = nl_;
    
%% D4 images
elseif (value == 4)
    fprintf("Providing D4 Results vs D5 as template.\n");
    d4 = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D4_Before_Registration.tif');
    l_ = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D4_After_LinearRegistration.tif');
    nl_ = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D4_After_Registration.tif');
    
    org = d4; lin = l_; nonlin = nl_;
    
%% D6 images
elseif (value == 6)
    fprintf("Providing D6 Results vs D5 as template.\n");
    d6 = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D6_Before_Registration.tif');
    l_ = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D6_After_LinearRegistration.tif');
    nl_ = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D6_After_Registration.tif');
    
    org = d6; lin = l_; nonlin = nl_;
     
%% D6 Rotated images
elseif (value == 66)
        fprintf("Providing D6_Rot Results vs D5 as template.\n");
        d6rot = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D6_Rot_Before_Registration.tif');
        l_ = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D6_Rot_After_LinearRegistration.tif');
        nl_ = imread('C:\Users\yogeshappa\Documents\Files_Hiwi\PostAnalysis\MI_Projection\D6_Rot_After_Registration.tif');
        
        org = d6rot; lin = l_; nonlin = nl_;
        
%% Invalid Input
else
    fprintf("Invalid value.\n");
end
end