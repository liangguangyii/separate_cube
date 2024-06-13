program main
    use math_function
    implicit none
    
    character(len=200):: filename
        
    type(atom), allocatable:: atom_list(:)
        
    integer:: reslu(3), atoms_num
        
    real*8:: origin(3), vecx(3), vecy(3), vecz(3)
    real*8, allocatable:: cubexyz(:,:,:)  
    
    filename = "z.cub"
    
    call separate_cube(filename)
    
end program main