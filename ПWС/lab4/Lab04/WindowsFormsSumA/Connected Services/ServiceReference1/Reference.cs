﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан программой.
//     Исполняемая версия:4.0.30319.42000
//
//     Изменения в этом файле могут привести к неправильной работе и будут потеряны в случае
//     повторной генерации кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WindowsFormsSumA.ServiceReference1 {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="A", Namespace="http://kni/")]
    [System.SerializableAttribute()]
    public partial class A : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string sField;
        
        private int kField;
        
        private float fField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false)]
        public string s {
            get {
                return this.sField;
            }
            set {
                if ((object.ReferenceEquals(this.sField, value) != true)) {
                    this.sField = value;
                    this.RaisePropertyChanged("s");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(IsRequired=true, Order=1)]
        public int k {
            get {
                return this.kField;
            }
            set {
                if ((this.kField.Equals(value) != true)) {
                    this.kField = value;
                    this.RaisePropertyChanged("k");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute(IsRequired=true, Order=2)]
        public float f {
            get {
                return this.fField;
            }
            set {
                if ((this.fField.Equals(value) != true)) {
                    this.fField = value;
                    this.RaisePropertyChanged("f");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(Namespace="http://kni/", ConfigurationName="ServiceReference1.SimplexSoap")]
    public interface SimplexSoap {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://kni/Add", ReplyAction="*")]
        int Add(int a, int b);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://kni/Add", ReplyAction="*")]
        System.Threading.Tasks.Task<int> AddAsync(int a, int b);
        
        // CODEGEN: Контракт генерации сообщений с именем a из пространства имен http://kni/ не отмечен как обнуляемый
        [System.ServiceModel.OperationContractAttribute(Action="http://kni/Concat", ReplyAction="*")]
        WindowsFormsSumA.ServiceReference1.ConcatResponse Concat(WindowsFormsSumA.ServiceReference1.ConcatRequest request);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://kni/Concat", ReplyAction="*")]
        System.Threading.Tasks.Task<WindowsFormsSumA.ServiceReference1.ConcatResponse> ConcatAsync(WindowsFormsSumA.ServiceReference1.ConcatRequest request);
        
        // CODEGEN: Контракт генерации сообщений с именем a из пространства имен http://kni/ не отмечен как обнуляемый
        [System.ServiceModel.OperationContractAttribute(Action="http://kni/Sum", ReplyAction="*")]
        WindowsFormsSumA.ServiceReference1.SumResponse Sum(WindowsFormsSumA.ServiceReference1.SumRequest request);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://kni/Sum", ReplyAction="*")]
        System.Threading.Tasks.Task<WindowsFormsSumA.ServiceReference1.SumResponse> SumAsync(WindowsFormsSumA.ServiceReference1.SumRequest request);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://kni/AddS", ReplyAction="*")]
        int AddS(int a, int b);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://kni/AddS", ReplyAction="*")]
        System.Threading.Tasks.Task<int> AddSAsync(int a, int b);
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class ConcatRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="Concat", Namespace="http://kni/", Order=0)]
        public WindowsFormsSumA.ServiceReference1.ConcatRequestBody Body;
        
        public ConcatRequest() {
        }
        
        public ConcatRequest(WindowsFormsSumA.ServiceReference1.ConcatRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://kni/")]
    public partial class ConcatRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string a;
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=1)]
        public string b;
        
        public ConcatRequestBody() {
        }
        
        public ConcatRequestBody(string a, string b) {
            this.a = a;
            this.b = b;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class ConcatResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="ConcatResponse", Namespace="http://kni/", Order=0)]
        public WindowsFormsSumA.ServiceReference1.ConcatResponseBody Body;
        
        public ConcatResponse() {
        }
        
        public ConcatResponse(WindowsFormsSumA.ServiceReference1.ConcatResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://kni/")]
    public partial class ConcatResponseBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public string ConcatResult;
        
        public ConcatResponseBody() {
        }
        
        public ConcatResponseBody(string ConcatResult) {
            this.ConcatResult = ConcatResult;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class SumRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="Sum", Namespace="http://kni/", Order=0)]
        public WindowsFormsSumA.ServiceReference1.SumRequestBody Body;
        
        public SumRequest() {
        }
        
        public SumRequest(WindowsFormsSumA.ServiceReference1.SumRequestBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://kni/")]
    public partial class SumRequestBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public WindowsFormsSumA.ServiceReference1.A a;
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=1)]
        public WindowsFormsSumA.ServiceReference1.A b;
        
        public SumRequestBody() {
        }
        
        public SumRequestBody(WindowsFormsSumA.ServiceReference1.A a, WindowsFormsSumA.ServiceReference1.A b) {
            this.a = a;
            this.b = b;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.ServiceModel.MessageContractAttribute(IsWrapped=false)]
    public partial class SumResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Name="SumResponse", Namespace="http://kni/", Order=0)]
        public WindowsFormsSumA.ServiceReference1.SumResponseBody Body;
        
        public SumResponse() {
        }
        
        public SumResponse(WindowsFormsSumA.ServiceReference1.SumResponseBody Body) {
            this.Body = Body;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
    [System.Runtime.Serialization.DataContractAttribute(Namespace="http://kni/")]
    public partial class SumResponseBody {
        
        [System.Runtime.Serialization.DataMemberAttribute(EmitDefaultValue=false, Order=0)]
        public WindowsFormsSumA.ServiceReference1.A SumResult;
        
        public SumResponseBody() {
        }
        
        public SumResponseBody(WindowsFormsSumA.ServiceReference1.A SumResult) {
            this.SumResult = SumResult;
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface SimplexSoapChannel : WindowsFormsSumA.ServiceReference1.SimplexSoap, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class SimplexSoapClient : System.ServiceModel.ClientBase<WindowsFormsSumA.ServiceReference1.SimplexSoap>, WindowsFormsSumA.ServiceReference1.SimplexSoap {
        
        public SimplexSoapClient() {
        }
        
        public SimplexSoapClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public SimplexSoapClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public SimplexSoapClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public SimplexSoapClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public int Add(int a, int b) {
            return base.Channel.Add(a, b);
        }
        
        public System.Threading.Tasks.Task<int> AddAsync(int a, int b) {
            return base.Channel.AddAsync(a, b);
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        WindowsFormsSumA.ServiceReference1.ConcatResponse WindowsFormsSumA.ServiceReference1.SimplexSoap.Concat(WindowsFormsSumA.ServiceReference1.ConcatRequest request) {
            return base.Channel.Concat(request);
        }
        
        public string Concat(string a, string b) {
            WindowsFormsSumA.ServiceReference1.ConcatRequest inValue = new WindowsFormsSumA.ServiceReference1.ConcatRequest();
            inValue.Body = new WindowsFormsSumA.ServiceReference1.ConcatRequestBody();
            inValue.Body.a = a;
            inValue.Body.b = b;
            WindowsFormsSumA.ServiceReference1.ConcatResponse retVal = ((WindowsFormsSumA.ServiceReference1.SimplexSoap)(this)).Concat(inValue);
            return retVal.Body.ConcatResult;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        System.Threading.Tasks.Task<WindowsFormsSumA.ServiceReference1.ConcatResponse> WindowsFormsSumA.ServiceReference1.SimplexSoap.ConcatAsync(WindowsFormsSumA.ServiceReference1.ConcatRequest request) {
            return base.Channel.ConcatAsync(request);
        }
        
        public System.Threading.Tasks.Task<WindowsFormsSumA.ServiceReference1.ConcatResponse> ConcatAsync(string a, string b) {
            WindowsFormsSumA.ServiceReference1.ConcatRequest inValue = new WindowsFormsSumA.ServiceReference1.ConcatRequest();
            inValue.Body = new WindowsFormsSumA.ServiceReference1.ConcatRequestBody();
            inValue.Body.a = a;
            inValue.Body.b = b;
            return ((WindowsFormsSumA.ServiceReference1.SimplexSoap)(this)).ConcatAsync(inValue);
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        WindowsFormsSumA.ServiceReference1.SumResponse WindowsFormsSumA.ServiceReference1.SimplexSoap.Sum(WindowsFormsSumA.ServiceReference1.SumRequest request) {
            return base.Channel.Sum(request);
        }
        
        public WindowsFormsSumA.ServiceReference1.A Sum(WindowsFormsSumA.ServiceReference1.A a, WindowsFormsSumA.ServiceReference1.A b) {
            WindowsFormsSumA.ServiceReference1.SumRequest inValue = new WindowsFormsSumA.ServiceReference1.SumRequest();
            inValue.Body = new WindowsFormsSumA.ServiceReference1.SumRequestBody();
            inValue.Body.a = a;
            inValue.Body.b = b;
            WindowsFormsSumA.ServiceReference1.SumResponse retVal = ((WindowsFormsSumA.ServiceReference1.SimplexSoap)(this)).Sum(inValue);
            return retVal.Body.SumResult;
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        System.Threading.Tasks.Task<WindowsFormsSumA.ServiceReference1.SumResponse> WindowsFormsSumA.ServiceReference1.SimplexSoap.SumAsync(WindowsFormsSumA.ServiceReference1.SumRequest request) {
            return base.Channel.SumAsync(request);
        }
        
        public System.Threading.Tasks.Task<WindowsFormsSumA.ServiceReference1.SumResponse> SumAsync(WindowsFormsSumA.ServiceReference1.A a, WindowsFormsSumA.ServiceReference1.A b) {
            WindowsFormsSumA.ServiceReference1.SumRequest inValue = new WindowsFormsSumA.ServiceReference1.SumRequest();
            inValue.Body = new WindowsFormsSumA.ServiceReference1.SumRequestBody();
            inValue.Body.a = a;
            inValue.Body.b = b;
            return ((WindowsFormsSumA.ServiceReference1.SimplexSoap)(this)).SumAsync(inValue);
        }
        
        public int AddS(int a, int b) {
            return base.Channel.AddS(a, b);
        }
        
        public System.Threading.Tasks.Task<int> AddSAsync(int a, int b) {
            return base.Channel.AddSAsync(a, b);
        }
    }
}
