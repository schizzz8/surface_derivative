clear;clc;

%define surface
[XX,YY] = meshgrid(-2:.1:2, 0:.1:2);
ZZ = XX .* exp(-XX.^2 - YY.^2);

%compute derivatives
[dzx,dzy]=derivative7(ZZ,'x','y');
[dyx,dyy]=derivative7(YY,'x','y');
[dxx,dxy]=derivative7(XX,'x','y');

%build tangent vectors
t1=[dxx(:),dyx(:),dzx(:)];
t2=[dxy(:),dyy(:),dzy(:)];

%compute normals
nn=zeros(size(XX,1)*size(XX,2),3);
for ii = 1:size(XX,1)*size(XX,2)
    nn(ii,:) = cross(t1(ii,:),t2(ii,:));
    nn(ii,:) = nn(ii,:)/norm(nn(ii,:));
end

%visualize surface and normals
plot3(XX(:),YY(:),ZZ(:),'.r')
hold on
quiver3(XX(:),YY(:),ZZ(:),nn(:,1),nn(:,2),nn(:,3))
