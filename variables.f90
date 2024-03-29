	!>@author
	!>Paul Connolly, The University of Manchester
	!>@brief
	!>variables for the simple cloud model
    module variables
    use numerics_type
	!>@author
	!>Paul J. Connolly, The University of Manchester
	!>@brief
	!>variables and types for the simple cloud model

    implicit none
        type grid
            ! variables for grid
            integer(i4b) :: n_levels,nq,ncat, nprec, &
                            iqv, iqc, iqr, iqi, iqs, iqg, inc, inr, ini, ins, ing, &
                            iai, &
                            cat_am, cat_c, cat_r, cat_i
            real(wp) :: dz, dt
            real(wp), dimension(:,:), allocatable :: q, qold, precip
            real(wp), dimension(:), allocatable :: theta, p, rho, z, t, u, dz2
            
            
            ! point to the start and end of a category
            integer(i4b), dimension(:), allocatable :: c_s, c_e
            character(len=20), dimension(:), allocatable :: q_name
            integer(i4b), dimension(:), allocatable :: q_type
            integer(i4b) :: n_mode
        end type grid

        type sounding
            ! variables for grid
            integer(i4b) :: n_levels
            real(wp), dimension(:,:), allocatable :: q
            real(wp), dimension(:), allocatable :: theta, p, z, rh
        end type sounding


        type io
            ! variables for io
            integer(i4b) :: ncid, varid, x_dimid, y_dimid, z_dimid, &
                            dimids(2), a_dimid, xx_dimid, yy_dimid, &
                            zz_dimid, i_dimid, j_dimid, k_dimid, nq_dimid, &
                            lq_dimid, nprec_dimid
            integer(i4b) :: icur=1
            logical :: new_file=.true.
        end type io


        ! declare a grid type
        type(grid) :: grid1
        ! declare a sounding type
        type(sounding) :: sounding1
        ! declare an io type
        type(io) :: io1

        ! constants
        integer(i4b), parameter :: nlevels_r=1000
        logical :: micro_init=.true., adiabatic_prof=.false.
        real(wp) :: adiabatic_frac
        logical :: monotone=.true.,theta_flag=.false., &
        			hm_flag=.true.,aero_prof_flag=.true.,ice_flag=.false., &
        			wr_flag=.true.,rm_flag=.true., heyms_west=.true.
        integer(i4b) :: advection_scheme=0,microphysics_flag=0, mode1_ice_flag=0, &
                    mode2_ice_flag=0,coll_breakup_flag1=0
        character (len=200) :: bam_nmlfile = ' '
        character (len=200) :: aero_nmlfile = ' '

        ! variables for model
        real(wp), allocatable, dimension(:,:) :: q_read !nq x nlevels_r
        real(wp), dimension(nlevels_r) :: theta_read,rh_read, &
                  z_read
        real(wp) :: dz,dt, runtime, psurf, theta_surf,tsurf, t_cbase, t_ctop, t_thresh, &
        			t_thresh2, w_peak, w_cb, theta_q_sat,t1old, p111, num_ice, mass_ice, &
        			num_drop
        integer(i4b) :: kp, n_levels_s, ord, o_halo,halo, updraft_type
        logical :: ice_init=.true., drop_num_init=.false.
        integer(i4b) :: nq = 9, qv=1,qc=2,qr=3,nqc=-1,nqr=-1,qs=4,qg=5,qi=6, &
                                   nqi=7,nqs=8,nqg=9, nprec=4

        ! the type of q-variable. 0 vapour, 1 mass, 2 number conc.
        integer(i4b), allocatable, dimension(:) :: q_type !=(/0,1,1,1,1,1,2,2,2,2,2/)
        ! whether to initialise or not
        logical, allocatable, dimension(:) :: q_init !=(/.true.,.false.,.false.,.false., &
                                            !.false.,.false.,.false.,.false., &
                                            !.false.,.false.,.false./)

        character (len=200) :: outputfile='output'
    end module variables




    module constants
        use numerics_type
	!>@author
	!>Paul J. Connolly, The University of Manchester
	!>@brief
	!>constants for the simple cloud model

        implicit none
        real(wp), parameter :: ra=287.0_wp, cp=1005.0_wp, grav=9.81_wp, &
        						rv=461._wp, eps1=ra/rv, lv=2.5e6_wp, ttr=273.15_wp
    end module constants







