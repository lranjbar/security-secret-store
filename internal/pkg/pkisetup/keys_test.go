/*
   Copyright 2019 DELL Technologies.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

  @author: Tingyu Zeng, DELL (created: May 21, 2019)
  @version: 1.0.0
*/

package pkisetup

import (
	"testing"
)

func TestGenSKWithValidConfig(t *testing.T) {
	myconfig := testConfig
	_, err := genSK(&myconfig)

	if err != nil {
		t.Errorf("Failed to create privatekey with correct configuration data.")
	}
}
