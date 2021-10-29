module optools_table_class
  implicit none

  !! Single and Double precision kinds
  integer, parameter :: sp = kind(1.0)
  integer, parameter :: dp = kind(1.0d0)

  private :: sp, dp
  public :: CK_table, lbl_table, CIA_table, nk_table

  type CK_table

    integer :: form          ! Table format - 1 = NEMESIS, 2 = HELIOS, 3 = SOCRATES, 4 = HITRAN (CIA)
    integer :: NEMESIS_op
    integer :: HELIOS_op     ! HELIOS cbin option - 1 = raw cbin, 2 = processed cbin
    integer :: SOCRATES_op
    integer :: HITRAN_op

    character(len=10) :: sp  ! Species name
    character(len=150) :: path ! Path to table data

    integer :: nwl
    real(kind=dp), allocatable, dimension(:) :: wl ! Central wavelengths of table (um)
    real(kind=dp), allocatable, dimension(:) :: wn ! Central wavenumbers of table (cm-1)
    real(kind=dp), allocatable, dimension(:) :: freq ! Central frequencies of table (Hz)

    integer :: iVMR ! VMR index for consituent species

    integer :: nT ! Number of temperature points in table
    real(kind=dp), allocatable, dimension(:) :: T  ! Temperature points in table (K)

    integer :: nP ! Number of pressure points in table
    real(kind=dp), allocatable, dimension(:) :: P ! Pressure points in table (dyne) [CARE UNITS!!]

    integer :: nG ! Number of g-ordinances (for corr-k)
    real(kind=dp), allocatable, dimension(:) :: Gx, Gw ! Gx ordinances in table, Gw weight of ordinances

    real(kind=dp), allocatable, dimension(:,:,:,:) :: k_abs ! Kappa values [cm2 molecule-1] (CARE: convert units from table source)

    integer :: sp_iflag   ! Special integer flag
    logical :: sp_lflag   ! Special logical flag

  end type CK_table


  type lbl_table

    integer :: form          ! Table format - 0 = Joost format, 1 = NEMESIS, 2 = HELIOS, 3 = SOCRATES, 4 = HITRAN (CIA)
    integer :: NEMESIS_op
    integer :: HELIOS_op
    integer :: SOCRATES_op
    integer :: HITRAN_op

    character(len=10) :: sp  ! Species name
    character(len=150) :: path ! Path to table data

    integer :: nwl
    real(kind=dp), allocatable, dimension(:) :: wl ! Central wavelengths of table (um)
    real(kind=dp), allocatable, dimension(:) :: wn ! Central wavenumbers of table (cm-1)
    real(kind=dp), allocatable, dimension(:) :: freq ! Central frequencies of table (Hz)

    integer :: iVMR ! VMR index for consituent species

    integer :: nT ! Number of temperature points in table
    real(kind=dp), allocatable, dimension(:) :: T  ! Temperature points in table (K)

    integer :: nP ! Number of pressure points in table
    real(kind=dp), allocatable, dimension(:) :: P ! Pressure points in table (dyne) [CARE UNITS!!]

    real(kind=dp), allocatable, dimension(:,:,:) :: k_abs ! Kappa values [cm2 molecule-1] (CARE: convert units from table source)

    integer :: sp_iflag   ! Special integer flag
    logical :: sp_lflag   ! Special logical flag

  end type lbl_table

  type CIA_table

    integer :: form          ! Table format - 1 = NEMESIS, 2 = HELIOS, 3 = SOCRATES, 4 = HITRAN (CIA)
    integer :: NEMESIS_op
    integer :: HELIOS_op     ! HELIOS cbin option - 1 = raw cbin, 2 = processed cbin
    integer :: SOCRATES_op
    integer :: HITRAN_op

    character(len=10) :: sp  ! Species name
    logical :: i3 = .False. ! Flag for 3 part special species
    character(len=10), dimension(2) :: sp_con ! Constituent species (for CIA)
    character(len=10), dimension(3) :: sp_con_3 ! Constituent species for 3 part special
    integer, dimension(2) :: iVMR ! VMR index for consituent species
    integer, dimension(3) :: iVMR_3 ! VMR index for 3 part special
    character(len=150) :: path ! Path to table data

    integer :: nwl
    real(kind=dp), allocatable, dimension(:) :: wl ! Central wavelengths of table (um)
    real(kind=dp), allocatable, dimension(:) :: wn ! Central wavenumbers of table (cm-1)
    real(kind=dp), allocatable, dimension(:) :: freq ! Central frequencies of table (Hz)

    integer :: nT ! Number of temperature points in table
    real(kind=dp), allocatable, dimension(:) :: T  ! Temperature points in table (K)

    real(kind=dp), allocatable, dimension(:,:) :: tab ! table values [Usually: cm5 molecule-2] (CARE: Check format units)

    integer :: sp_iflag   ! Special integer flag
    logical :: sp_lflag   ! Special logical flag

  end type CIA_table

  type nk_table

    integer :: form          ! Table format - 1 = NEMESIS, 2 = HELIOS, 3 = SOCRATES, 4 = HITRAN (CIA), 5 = DIHRT
    integer :: NEMESIS_op
    integer :: HELIOS_op     ! HELIOS cbin option - 1 = raw cbin, 2 = processed cbin
    integer :: SOCRATES_op
    integer :: HITRAN_op
    integer :: DIHRT_op

    character(len=10) :: sp  ! Species name
    character(len=150) :: path ! Path to table data

    integer :: nwl
    real(kind=dp), allocatable, dimension(:) :: wl ! Central wavelengths of table (um)
    real(kind=dp), allocatable, dimension(:) :: wn ! Central wavenumbers of table (cm-1)
    real(kind=dp), allocatable, dimension(:) :: freq ! Central frequencies of table (Hz)

    integer :: iVMR ! VMR index for consituent species

    logical :: conducting ! Species is conducting flag

    real(kind=dp), allocatable, dimension(:) :: n  ! Real refractive index
    real(kind=dp), allocatable, dimension(:) :: k  ! Imaginary refractive index

    integer :: sp_iflag   ! Special integer flag
    logical :: sp_lflag   ! Special logical flag

  end type nk_table

end module optools_table_class
