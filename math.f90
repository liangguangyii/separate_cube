module math_function
    use fileIO
    implicit none
    
    contains
    
    subroutine separate_cube(filename)
        character(len=200), intent(in):: filename
        character(len=200):: filename_p, filename_n
        real*8, allocatable:: cubexyz_p(:,:,:), cubexyz_n(:,:,:)
        
        integer:: i, j, k
        
        type(atom), allocatable:: atom_list(:)
        
        integer:: reslu(3), atoms_num
        
        real*8:: origin(3), vecx(3), vecy(3), vecz(3)
        real*8, allocatable:: cubexyz(:,:,:)   
        
        call cuberead(filename, reslu, atoms_num, atom_list, origin, vecx, vecy, vecz, cubexyz)
        
        allocate(cubexyz_p(reslu(1),reslu(2),reslu(3)), &
                 cubexyz_n(reslu(1),reslu(2),reslu(3)))
        
        cubexyz_p = 0D0
        cubexyz_n = 0D0
        
        !separate the cube into positive and negative part
        
        do i = 1, reslu(1)
            do j = 1, reslu(2)
                do k = 1, reslu(3)
                    if (cubexyz(i,j,k) > 0) then
                        cubexyz_p(i,j,k) = cubexyz(i,j,k)
                    else
                        cubexyz_n(i,j,k) = cubexyz(i,j,k)
                    end if
                end do
            end do
        end do

        filename_p = "position.cub"
        filename_n = "negative.cub"
        
        call cubewrite(filename_p, reslu, atoms_num, atom_list, origin, vecx, vecy, vecz, cubexyz_p)
        call cubewrite(filename_n, reslu, atoms_num, atom_list, origin, vecx, vecy, vecz, cubexyz_n)
    
    end subroutine separate_cube
end module math_function