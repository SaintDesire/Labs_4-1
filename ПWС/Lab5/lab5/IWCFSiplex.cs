using System.ServiceModel;

namespace lab5
{
    [ServiceContract]
    public interface IWCFSiplex
    {
        [OperationContract]
        int Add(int x, int y);

        [OperationContract]
        string Concat(string s, double d);

        [OperationContract]
        A Sum(A a1, A a2);
    }
 
}
