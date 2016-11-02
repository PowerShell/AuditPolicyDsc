
$script:DSCModuleName      = 'AuditPolicyDsc'
$script:DSCResourceName    = 'MSFT_AuditPolicySubcategory'

#region HEADER
[String] $script:moduleRoot = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $script:MyInvocation.MyCommand.Path))
if ( (-not (Test-Path -Path (Join-Path -Path $moduleRoot -ChildPath 'DSCResource.Tests'))) -or `
     (-not (Test-Path -Path (Join-Path -Path $moduleRoot -ChildPath 'DSCResource.Tests\TestHelper.psm1'))) )
{
    & git @('clone','https://github.com/PowerShell/DscResource.Tests.git',(Join-Path -Path $moduleRoot -ChildPath '\DSCResource.Tests\'))
}
else
{
    & git @('-C',(Join-Path -Path $moduleRoot -ChildPath '\DSCResource.Tests\'),'pull')
}
Import-Module (Join-Path -Path $moduleRoot -ChildPath 'DSCResource.Tests\TestHelper.psm1') -Force
$TestEnvironment = Initialize-TestEnvironment `
    -DSCModuleName $script:DSCModuleName `
    -DSCResourceName $script:DSCResourceName `
    -TestType Unit 
#endregion

# Begin Testing
try
{
    #region Pester Tests

    InModuleScope $script:DSCResourceName {

        Describe "$($script:DSCResourceName)\Get-TargetResource" {
            
            $testParameters = @{
                Subcategory = 'Logon'
                AuditFlag   = 'Success'
            }

            Context "Single word subcategory submit 'Success' and return 'Success'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'Success' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Success'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Present'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Single word subcategory submit 'Success' and return 'Failure'" {
                
                Mock -CommandName Get-AuditCategory -MockWith { return 'Failure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties from a Single word subcategory' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Failure'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Absent'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Single word subcategory submit 'Success' and return 'NoAuditing'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'NoAuditing' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'NoAuditing'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Absent'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Single word subcategory submit 'Success' and return 'SuccessandFailure'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'SuccessandFailure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable
            
                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Success'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Present'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            $testParameters.AuditFlag = 'Failure'

            Context "Single word subcategory submit 'Failure' and return 'Success'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'Success' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Success'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Absent'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Single word subcategory submit 'Failure' and return 'Failure'" {
                
                Mock -CommandName Get-AuditCategory -MockWith { return 'Failure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties from a Single word subcategory' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Failure'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Present'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Single word subcategory submit 'Failure' and return 'NoAuditing'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'NoAuditing' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'NoAuditing'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Absent'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Single word subcategory submit 'Failure' and return 'SuccessandFailure'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'SuccessandFailure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable
            
                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Failure'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Present'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            $testParameters.Subcategory = 'Credential Validation'
            $testParameters.AuditFlag   = 'Success'

            Context "Mulit-word subcategory submit 'Success' and return 'Success'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'Success' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Success'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Present'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Mulit-word subcategory submit 'Success' and return 'Failure'" {
                
                Mock -CommandName Get-AuditCategory -MockWith { return 'Failure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Failure'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Absent'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Mulit-word subcategory submit 'Success' and return 'NoAuditing'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'NoAuditing' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'NoAuditing'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Absent'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Mulit-word subcategory submit 'Success' and return 'SuccessandFailure'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'SuccessandFailure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable
            
                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Success'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Present'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            $testParameters.AuditFlag = 'Failure'

            Context "Mulit-word subcategory submit 'Failure' and return 'Success'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'Success' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Success'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Absent'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Mulit-word subcategory submit 'Failure' and return 'Failure'" {
                
                Mock -CommandName Get-AuditCategory -MockWith { return 'Failure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties from a Single word subcategory' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Failure'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Present'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Mulit-word subcategory submit 'Failure' and return 'NoAuditing'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'NoAuditing' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'NoAuditing'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Absent'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context "Mulit-word subcategory submit 'Failure' and return 'SuccessandFailure'" {

                Mock -CommandName Get-AuditCategory -MockWith { return 'SuccessandFailure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable
            
                It 'Should not throw an exception' {
                    { $script:getTargetResourceResult = Get-TargetResource @testParameters } | 
                        Should Not Throw
                }

                It 'Should return the correct hashtable properties' {
                    $script:getTargetResourceResult.Subcategory | Should Be $testParameters.Subcategory
                    $script:getTargetResourceResult.AuditFlag   | Should Be 'Failure'
                    $script:getTargetResourceResult.Ensure      | Should Be 'Present'
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }
        }

        Describe "$($script:DSCResourceName)\Test-TargetResource" {
            
            $testParameters = @{
                Subcategory = 'Logon'
                AuditFlag   = 'Success'
                Ensure      = 'Present'
            }    

            Context 'Single word subcategory Success flag present and should be' {
                Mock -CommandName Get-AuditCategory -MockWith { return 'Success' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:testTargetResourceResult = Test-TargetResource @testParameters } |
                        Should Not Throw
                }

                It 'Should return true' {
                    $script:testTargetResourceResult | Should Be $true
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context 'Single word subcategory Success flag present and should not be' {
                
                $testParameters.Ensure = 'Absent'
                Mock -CommandName Get-AuditCategory -MockWith { return 'Success' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:testTargetResourceResult = Test-TargetResource @testParameters } | Should Not Throw
                }

                It 'Should return false' {
                    $script:testTargetResourceResult | Should Be $false
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                }
            }
            
            $testParameters.AuditFlag   = 'Failure'

            Context 'Single word subcategory failure flag present and should be' {

                $testParameters.Ensure = 'Present'
                Mock -CommandName Get-AuditCategory -MockWith { return 'failure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:testTargetResourceResult = Test-TargetResource @testParameters } |
                        Should Not Throw
                }

                It 'Should return true' {
                    $script:testTargetResourceResult | Should Be $true
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context 'Single word subcategory failure flag present and should not be' {
                
                $testParameters.Ensure = 'Absent'
                Mock -CommandName Get-AuditCategory -MockWith { return 'failure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:testTargetResourceResult = Test-TargetResource @testParameters } | Should Not Throw
                }

                It 'Should return false' {
                    $script:testTargetResourceResult | Should Be $false
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                }
            }

            $testParameters.AuditFlag   = 'Success'
            $testParameters.Subcategory = 'Credential Validation'

            Context 'Multi-word subcategory Success flag present and should be' {
                
                $testParameters.Ensure = 'Present'
                Mock -CommandName Get-AuditCategory -MockWith { return 'Success' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:testTargetResourceResult = Test-TargetResource @testParameters } |
                        Should Not Throw
                }

                It 'Should return true' {
                    $script:testTargetResourceResult | Should Be $true
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context 'Multi-word subcategory Success flag present and should not be' {
                
                $testParameters.Ensure = 'Absent'
                Mock -CommandName Get-AuditCategory -MockWith { return 'Success' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:testTargetResourceResult = Test-TargetResource @testParameters } | Should Not Throw
                }

                It 'Should return false' {
                    $script:testTargetResourceResult | Should Be $false
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                }
            }

            $testParameters.AuditFlag   = 'Failure'

            Context 'Multi-word subcategory failure flag present and should be' {

                $testParameters.Ensure = 'Present'
                Mock -CommandName Get-AuditCategory -MockWith { return 'failure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:testTargetResourceResult = Test-TargetResource @testParameters } |
                        Should Not Throw
                }

                It 'Should return true' {
                    $script:testTargetResourceResult | Should Be $true
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                } 
            }

            Context 'Multi-word subcategory failure flag present and should not be' {
                
                $testParameters.Ensure = 'Absent'
                Mock -CommandName Get-AuditCategory -MockWith { return 'failure' } `
                     -ModuleName MSFT_AuditPolicySubcategory -Verifiable

                It 'Should not throw an exception' {
                    { $script:testTargetResourceResult = Test-TargetResource @testParameters } | Should Not Throw
                }

                It 'Should return false' {
                    $script:testTargetResourceResult | Should Be $false
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Get-AuditCategory -Exactly 1
                }
            }
        }

        Describe "$($script:DSCResourceName)\Set-TargetResource" {
            
            $testParameters = @{
                Subcategory = 'Logon'
                AuditFlag   = 'Success'
                Ensure      = 'Present'
            }  

            Context 'Set single word subcategory success flag to present' {

                Mock -CommandName Set-AuditCategory -MockWith { } -Verifiable

                It 'Should not throw an exception' {
                    { Set-TargetResource @testParameters } | Should Not Throw
                }   

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Set-AuditCategory -Exactly 1
                } 
            }

            Context 'Set single word subcategory failure flag to present' {
                
                $testParameters.AuditFlag = 'Failure'
                Mock -CommandName Set-AuditCategory -MockWith { } -Verifiable

                It 'Should not throw an exception' {
                    { Set-TargetResource @testParameters } | Should Not Throw
                }   

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Set-AuditCategory -Exactly 1
                } 
            }

            Context 'Set single word subcategory success flag to absent' {

                $testParameters.Ensure    = 'Absent'
                $testParameters.AuditFlag = 'Success'
                Mock -CommandName Set-AuditCategory -MockWith { } -Verifiable

                It 'Should not throw an exception' {
                    { Set-TargetResource @testParameters } | Should Not Throw
                }   

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Set-AuditCategory -Exactly 1
                } 
            }

            Context 'Set single word subcategory failure flag to absent' {
                
                $testParameters.AuditFlag = 'Failure'
                Mock -CommandName Set-AuditCategory -MockWith { } -Verifiable

                It 'Should not throw an exception' {
                    { Set-TargetResource @testParameters } | Should Not Throw
                }   

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Set-AuditCategory -Exactly 1
                } 
            }

            Context 'Set multi-word subcategory success flag to present' {

                $testParameters.Subcategory = 'Credential Validation'
                $testParameters.AuditFlag   = 'Success'
                $testParameters.Ensure      = 'Present'
                Mock -CommandName Set-AuditCategory -MockWith { } -Verifiable

                It 'Should not throw an exception' {
                    { Set-TargetResource @testParameters } | Should Not Throw
                }   

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Set-AuditCategory -Exactly 1
                } 
            }

            Context 'Set multi-word subcategory failure flag to present' {
                
                $testParameters.AuditFlag = 'Failure'
                Mock -CommandName Set-AuditCategory -MockWith { } -Verifiable

                It 'Should not throw an exception' {
                    { Set-TargetResource @testParameters } | Should Not Throw
                }   

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Set-AuditCategory -Exactly 1
                } 
            }

            Context 'Set single word subcategory success flag to absent' {

                $testParameters.AuditFlag = 'Success'
                $testParameters.Ensure    = 'Absent'
                Mock -CommandName Set-AuditCategory -MockWith { } -Verifiable

                It 'Should not throw an exception' {
                    { Set-TargetResource @testParameters } | Should Not Throw
                }   

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Set-AuditCategory -Exactly 1
                } 
            }

            Context 'Set single word subcategory failure flag to absent' {
                
                $testParameters.AuditFlag = 'Failure'
                Mock -CommandName Set-AuditCategory -MockWith { } -Verifiable

                It 'Should not throw an exception' {
                    { Set-TargetResource @testParameters } | Should Not Throw
                }   

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Set-AuditCategory -Exactly 1
                } 
            }
        }

        Describe 'Private function Get-AuditCategory'  {
            
            [String] $subCategory = 'Logon'
            
            Context 'Get single word audit category success flag' {
    
                [String] $auditFlag   = 'Success'
                <# 
                    The return is 3 lines Header, blank line, data
                    ComputerName,System,Subcategory,GUID,AuditFlags
                 #>
                 Mock -CommandName Invoke-Auditpol -MockWith { 
                     @("","","$env:ComputerName,system,$subCategory,[GUID],$auditFlag") } `
                     -ParameterFilter { $Command -eq 'Get' } -Verifiable

                It 'Should not throw an exception' {
                    { $script:getAuditCategoryResult = Get-AuditCategory -SubCategory $subCategory } | 
                        Should Not Throw
                } 
                
                It 'Should return the correct value' {
                    $script:getAuditCategoryResult | Should Be $auditFlag
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Invoke-Auditpol -Exactly 1
                } 
            }

            Context 'Get single word audit category failure flag' {

                [String] $auditFlag   = 'failure'
                <# 
                    The return is 3 lines Header, blank line, data
                    ComputerName,System,Subcategory,GUID,AuditFlags
                 #>
                 Mock -CommandName Invoke-Auditpol -MockWith { 
                     @("","","$env:ComputerName,system,$subCategory,[GUID],$auditFlag") } `
                     -ParameterFilter { $Command -eq 'Get' } -Verifiable

                It 'Should not throw an exception' {
                    { $script:getAuditCategoryResult = Get-AuditCategory -SubCategory $subCategory } | 
                        Should Not Throw
                } 
                
                It 'Should return the correct value' {
                    $script:getAuditCategoryResult | Should Be $auditFlag
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Invoke-Auditpol -Exactly 1
                } 
            }

            [String] $subCategory = 'Credential Validation'

            Context 'Get single word audit category success flag' {

                [String] $auditFlag   = 'Success'
                # the return is 3 lines Header, blank line, data
                # ComputerName,System,Subcategory,GUID,AuditFlags
                 Mock -CommandName Invoke-Auditpol -MockWith { 
                     @("","","$env:ComputerName,system,$subCategory,[GUID],$auditFlag") } `
                     -ParameterFilter { $Command -eq 'Get' } -Verifiable

                It 'Should not throw an exception' {
                    { $script:getAuditCategoryResult = Get-AuditCategory -SubCategory $subCategory } | 
                        Should Not Throw
                } 
                
                It 'Should return the correct value' {
                    $script:getAuditCategoryResult | Should Be $auditFlag
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Invoke-Auditpol -Exactly 1
                } 
            }

            Context 'Get single word audit category failure flag' {

                [String] $auditFlag   = 'failure'
                # the return is 3 lines Header, blank line, data
                # ComputerName,System,Subcategory,GUID,AuditFlags
                 Mock -CommandName Invoke-Auditpol -MockWith { 
                     @("","","$env:ComputerName,system,$subCategory,[GUID],$auditFlag") } `
                     -ParameterFilter { $Command -eq 'Get' } -Verifiable

                It 'Should not throw an exception' {
                    { $script:getAuditCategoryResult = Get-AuditCategory -SubCategory $subCategory } | 
                        Should Not Throw
                } 
                
                It 'Should return the correct value' {
                    $script:getAuditCategoryResult | Should Be $auditFlag
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Invoke-Auditpol -Exactly 1
                } 
            }
        }

        Describe 'Private function Set-AuditCategory' {

            Context 'Set single word audit category Success flag to Present' {
                
                Mock -CommandName Invoke-Auditpol -MockWith { } -ParameterFilter {
                    $Command -eq 'Set' } -Verifiable
                    
                $comamnd = @{
                    SubCategory = "Logon"
                    AuditFlag = "Success"
                    Ensure = "Present"
                }

                It 'Should not throw an error' {
                    { Set-AuditCategory @comamnd } | Should Not Throw 
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Invoke-Auditpol -Exactly 1
                } 
            }

            Context 'Set single word audit category Success flag to Absent' {
                
                Mock -CommandName Invoke-Auditpol -MockWith { } -ParameterFilter {
                    $Command -eq 'Set' } -Verifiable
                    
                $comamnd = @{
                    SubCategory = "Logon"
                    AuditFlag = "Success"
                    Ensure = "Absent"
                }

                It 'Should not throw an exception' {
                    { Set-AuditCategory @comamnd } | Should Not Throw 
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Invoke-Auditpol -Exactly 1
                } 
            }

            Context 'Set multi-word audit category Success flag to Present' {
                
                Mock -CommandName Invoke-Auditpol -MockWith { } -ParameterFilter {
                    $Command -eq 'Set' } -Verifiable
                    
                $comamnd = @{
                    SubCategory = "Object Access"
                    AuditFlag = "Success"
                    Ensure = "Present"
                }

                It 'Should not throw an exception' {
                    { Set-AuditCategory @comamnd } | Should Not Throw 
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Invoke-Auditpol -Exactly 1
                } 
            }

            Context 'Set multi-word audit category Success flag to Absent' {
                
                Mock -CommandName Invoke-Auditpol -MockWith { } -ParameterFilter {
                    $Command -eq 'Set' } -Verifiable
                    
                $comamnd = @{
                    SubCategory = "Object Access"
                    AuditFlag = "Success"
                    Ensure = "Absent"
                }

                It 'Should not throw an exception' {
                    { Set-AuditCategory @comamnd } | Should Not Throw 
                }

                It 'Should call expected Mocks' {    
                    Assert-VerifiableMocks
                    Assert-MockCalled -CommandName Invoke-Auditpol -Exactly 1
                } 
            }
        }
        #endregion
    }
    #endregion
}
finally
{
    #region FOOTER
    Restore-TestEnvironment -TestEnvironment $TestEnvironment
    #endregion
}
